import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/models/mock_questions.dart';
import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';

import '../models/question.dart';

class GameController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _countdownController;
  late Animation _countdown;

  final List<Question> questionList = sampleQuestions
      .map((question) =>
      Question(
        id: question['id'],
        type: question['type'],
        correct: question['correct'],
        fullCorrect: question['full correct'],
        additionInfo: question['addition info'],
        clock: question['clock'],
      ))
      .toList();

  int _currentPoint = 0;
  int _index = 0;
  String _userAnswer = '';
  int _bet = 0;
  int _result = 0;
  late int questionLength;
  late int _duration;


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    questionLength = sampleQuestions.length;

    _countdownController = AnimationController(
        duration: Duration(seconds: questionList[index].clock), vsync: this);

    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController)
      ..addListener(() {
        // update = setState
        update();
      });

    super.onInit();
  }

  @override
  void onClose() {
    print("QuestionController closed");
    _countdownController.dispose();
    super.onClose();
  }


  // getters
  Animation get countdown => _countdown;

  int get currentPoint => _currentPoint;

  int get index => _index;

  String get resultString =>
      (_result >= 0) ? ("+" + _result.toString()) : _result.toString();

  int get bet => _bet;

  String get userAnswer => _userAnswer;

  String get fullCorrectAnswer => questionList[index].fullCorrect;

  int get duration => _duration;


  // settlers
  void setUserAnswer(value) {
    _userAnswer = value.toString().toUpperCase();
  }

  void setBet(value) {
    _bet = int.parse(value);
  }


  // helpful methods

  void checkAnswer() {
    _countdownController.stop();

    if (_userAnswer == questionList[index].correct) {
      _result = _bet;
      print("correct answer");
    } else {
      _result = -_bet;
      print("wrong answer");
    }

    _currentPoint += _result;
    update();
  }

  void resetQuestionState() {
    print("index ${index}, timer: ${questionList[index].clock}");

    _duration = questionList[index].clock;

    // _countdownController.dispose();

    _countdownController.duration =
        Duration(seconds: questionList[index].clock);
    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController);
    update();

    // _countdownController.resync(this);
    _countdownController.reset();
    _countdownController.forward();
  }


  // page 1
  void gotoQuestionTitle() {
    // placeholder for end of question list
    if (_index >= questionLength - 1) {
      _index = 0;
    } else {
      _index++;
    }

    Get.to(const QuestionTitlePage());

    Future.delayed(const Duration(seconds: 3), () {
      gotoPollPage();
    });
  }

  // page 2
  void gotoPollPage() {
    resetQuestionState();

    Get.to(QuestionPollPage());
  }

  // page 3
  void gotoAnswerInfo() {
    _countdownController.stop();

    // no fun facts to show, go to page 1
    if (questionList[index].additionInfo != null) {
      Get.to(const AnswerInfoPage());
      Future.delayed(const Duration(seconds: 3), () {
        gotoAnswerReveal();
      });
    } else {
      gotoAnswerReveal();
    }
  }

  // page 4
  void gotoAnswerReveal() {
    Get.to(const AnswerRevealPage());

    Future.delayed(const Duration(seconds: 3), () {
      gotoQuestionTitle();
    });
  }
}
