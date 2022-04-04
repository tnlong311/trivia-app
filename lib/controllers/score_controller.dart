import 'dart:async';

import 'package:get/get.dart';

import '../models/answer.dart';
import '../models/mock_questions.dart';

class ScoreController extends GetxController
    with GetTickerProviderStateMixin {

  int _currentPoint = 0;
  int _index = 0;
  String _userAnswer = "";
  int _bet = 0;
  int _result = 0;
  late int questionLength;

  final List<Answer> answerList = sampleQuestions
      .map((question) =>
      Answer(
        id: question['id'],
        type: question['type'],
        correct: question['correct'],
        fullCorrect: question['full correct'],
      ))
      .toList();


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    questionLength = answerList.length;

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

  String get fullCorrectAnswer => answerList[index].fullCorrect;

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
    print(answerList[index].correct);

    if (_userAnswer == answerList[index].correct) {
      _result = _bet;
      print("correct answer");
    } else {
      _result = -_bet;
      print("wrong answer");
    }

    _currentPoint += _result;
    update();
  }

  void resetAnswerState() {

  }

  void increaseIndex() {
    _index ++;
  }
}
