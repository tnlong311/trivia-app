import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/models/mock_questions.dart';

class QuestionController extends GetxController with GetTickerProviderStateMixin {
  // for countdown
  late AnimationController _countdownController;
  late Animation _countdown;

  int _currentPoint = 0;
  int _index = 1;
  String _correctAnswer = '';
  String _userAnswer = '';
  int _bet = 0;
  int _result = 0;
  late int questionLength;

  // expose to global use
  Animation get countdown => _countdown;
  int get currentPoint => _currentPoint;
  int get index => _index;
  int get result => _result;


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _countdownController =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController)
      ..addListener(() {
        // update = setState
        update();
      });

    questionLength = sampleQuestions.length;

    // _countdownController.forward();

    super.onInit();
  }

  @override
  void onClose() {
    _countdownController.dispose();
    super.onClose();
  }

  void resetCounter(){
    _countdownController.reset();
    _countdownController.forward();
  }

  void checkAnswer(){
    _currentPoint += 100;
  }

  void gotoQuestionTitle() {

  }

  void gotoPollPage() {

  }

  void gotoAnswerReveal() {

  }

  void gotoAnswerInfo() {

  }
}

