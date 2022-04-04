import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/controllers/score_controller.dart';
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
        additionInfo: question['addition info'],
        clock: question['clock'],
      ))
      .toList();

  int _index = 0;
  late int questionLength;


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    questionLength = questionList.length;

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

  int get index => _index;

  String? get additionInfo => questionList[index].additionInfo;

  int get duration => questionList[index].clock;

  // helpful methods

  void resetQuestionState() {
    print("index $index, timer: ${questionList[index].clock}");

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
      ScoreController _scoreController = Get.put(ScoreController());
      _scoreController.increaseIndex();
      _index++;
    }

    Get.toNamed(QuestionTitlePage.routeName);

    Future.delayed(const Duration(seconds: 3), () {
      gotoPollPage();
    });
  }

  // page 2
  void gotoPollPage() {
    resetQuestionState();

    Get.toNamed(QuestionPollPage.routeName);
  }

  // page 3
  void gotoAnswerInfo() {
    _countdownController.stop();

    // no fun facts to show, go to page 1
    if (questionList[index].additionInfo != null) {
      Get.toNamed(AnswerInfoPage.routeName);
      Future.delayed(const Duration(seconds: 3), () {
        gotoAnswerReveal();
      });
    } else {
      gotoAnswerReveal();
    }
  }

  // page 4
  void gotoAnswerReveal() {
    Get.toNamed(AnswerRevealPage.routeName);

    Future.delayed(const Duration(seconds: 6), () {
      gotoQuestionTitle();
    });
  }
}
