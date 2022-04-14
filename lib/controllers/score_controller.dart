import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/user_const.dart';
import 'package:trivia_app/services/auth_service.dart';
import 'package:trivia_app/services/user_service.dart';

import '../models/answer.dart';
import '../services/game_service.dart';

class ScoreController extends GetxController with GetTickerProviderStateMixin {
  int _total = -1;
  int _index = 0;
  String _userAnswer = '';
  int _bet = 0;
  int _result = 0;
  bool _isAnswered = false;

  final List<Answer> _answerList = [];

  // getters
  int get totalPoint => _total;

  int get index => _index;

  String get resultString =>
      (_result >= 0) ? ("+" + _result.toString()) : _result.toString();

  int get bet => _bet;

  String get userAnswer => _userAnswer;

  bool get isAnswered => _isAnswered;

  String get fullCorrectAnswer => _answerList[index].fullCorrect;

  int get questionsLength => _answerList.length;

  // settlers
  void setIndex(int value) {
    _index = value;
  }

  void setUserAnswer(value) {
    _userAnswer = value.toString().trim();
  }

  void setBet(value) {
    _bet = int.parse(value.toString().trim());
  }

  void setAnswerState(bool state) {
    _isAnswered = state;
  }

  // helpful methods
  bool isWin() {
    if (_result < 0) {
      return false;
    }

    return true;
  }

  Future<void> fetchAnswers() async {
    if (_answerList.isEmpty) {
      DatabaseReference questionRef =
          FirebaseDatabase.instance.ref().child('/game bank/2022/questions');

      await questionRef
          .get()
          .then((DataSnapshot snapshot) {
            for (var q in (snapshot.value as List)) {
              if (q != null) {
                Answer answer = Answer.fromRTDB(q);
                _answerList.add(answer);
              }
            }
          })
          .then((_) => print('answer list fetched'))
          .catchError((error) => print(error));
    }
  }

  Future<void> fetchChange() async {
    var pin = await RtdbUserService.getCurrentUserPin();

    _result = await RtdbGameService.getCurrentQuestionScore(pin, _index);
    print('score is $_result');
  }

  Future<void> fetchTotalScore() async {
    var pin = await RtdbUserService.getCurrentUserPin();

    _total = await RtdbGameService.getUserTotalScore(pin);
  }

  Future<bool> checkAndPostAnswer() async {
    print('bet=$_bet, user answered=$_userAnswer');
    print('user answered '
        '${_answerList[index].correct == _userAnswer ? 'correct' : 'wrong'}');
    print('correct answer ${_answerList[index].correct}');

    if (_userAnswer.toLowerCase() == _answerList[index].correct.toLowerCase()) {
      _result = _bet;
    } else {
      if (_total == 0) {
        _result = 0;
      } else {
        _result = -_bet;
      }
    }

    // update();
    var result1 = await RtdbGameService.postScoreChange(
        AuthService.getPin(), _index, _result);
    if (!result1) {
      // post failed
      return false;
    }

    var result2 = await RtdbGameService.postUserAnswer(
        AuthService.getPin(), _index, _userAnswer);
    if (!result2) {
      return false;
    }

    return true;
  }

  Future<void> resetAnswerState() async {
    _isAnswered = false;
    await fetchTotalScore();
  }

  // called immediately after the widget is allocated memory
  @override
  void onInit() async {
    super.onInit();

    await fetchAnswers();
  }

  @override
  void onClose() {
    print("ScoreController closed");
    super.onClose();
  }
}
