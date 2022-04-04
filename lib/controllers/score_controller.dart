import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../models/answer.dart';
import '../models/mock_questions.dart';

class ScoreController extends GetxController with GetTickerProviderStateMixin {
  int _currentPoint = 2000;
  int _index = 0;
  String _userAnswer = "";
  int _bet = 0;
  int _result = 0;
  late final int questionLength;

  final List<Answer> _answerList = [];

  // final List<Answer> answerList = sampleQuestions
  //     .map((question) =>
  //     Answer(
  //       id: question['id'],
  //       type: question['type'],
  //       correct: question['correct'],
  //       fullCorrect: question['full correct'],
  //     ))
  //     .toList();

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

  String get fullCorrectAnswer => _answerList[index].fullCorrect;

  // settlers
  void setUserAnswer(value) {
    _userAnswer = value.toString().toUpperCase();
  }

  void setBet(value) {
    _bet = int.parse(value);
  }

  // helpful methods

  void checkAnswer() {
    // _countdownController.stop();
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
  }

  void resetAnswerState() {}

  void increaseIndex() {
    _index++;
  }
}