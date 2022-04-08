import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/user_const.dart';
import 'package:trivia_app/services/auth_service.dart';

import '../models/answer.dart';
import '../services/game_service.dart';

class ScoreController extends GetxController with GetTickerProviderStateMixin {
  int _currentPoint = DEFAULT_SCORE;
  int _index = 0;
  String _userAnswer = "";
  int _bet = 0;
  int _result = 0;
  final bool _isAnswered = false;
  late final int questionLength;

  final List<Answer> _answerList = [];

  // called immediately after the widget is allocated memory
  @override
  void onInit() async {
    DatabaseReference questionRef =
        FirebaseDatabase.instance.ref().child('/game bank/2022/questions');

    await questionRef.get().then((DataSnapshot snapshot) {
      for (var q in (snapshot.value as List)) {
        if (q != null) {
          Answer answer = Answer.fromRTDB(q);
          _answerList.add(answer);
        }
      }
    }).catchError((error) => print(error));

    questionLength = _answerList.length;

    await fetchIndex();

    super.onInit();
  }

  @override
  void onClose() {
    print("ScoreController closed");
    super.onClose();
  }

  // getters
  int get currentPoint => _currentPoint;

  int get index => _index;

  String get resultString =>
      (_result >= 0) ? ("+" + _result.toString()) : _result.toString();

  int get bet => _bet;

  String get userAnswer => _userAnswer;

  bool get isAnswered => _isAnswered;

  String get fullCorrectAnswer => _answerList[index].fullCorrect;

  // settlers
  void setUserAnswer(value) {
    _userAnswer = value.toString().toUpperCase();
  }

  void setBet(value) {
    _bet = int.parse(value);
  }

  // helpful methods

  Future<void> checkAnswer() async {
    // _countdownController.stop();
    print(_bet);
    print(_userAnswer);

    print(_answerList[index].correct);

    if (_userAnswer == _answerList[index].correct) {
      _result = _bet;
      print("correct answer");
    } else {
      _result = -_bet;
      print("wrong answer");
    }

    _currentPoint += _result;

    update();

    await RtdbGameService.postScoreChange(AuthService.getPin(), _index+1, _result);
    await RtdbGameService.postTotalScore(AuthService.getPin(), _currentPoint);
  }

  Future<void> fetchIndex() async {
    _index = await RtdbGameService.getCurrentIndex();
  }

  Future<void> fetchCurrentScore() async {

  }

  void resetAnswerState() {}

}
