import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/models/mock_questions.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';

import '../models/question.dart';

class QuestionController extends GetxController
    with GetTickerProviderStateMixin {
  // for countdown
  late AnimationController _countdownController;
  late Animation _countdown;

  int _currentPoint = 0;
  int _index = 0;
  String _userAnswer = '';
  int _bet = 0;
  int _result = 0;

  // late int questionLength;

  final List<Question> _questionList = sampleQuestions
      .map((question) => Question(
            id: question['id'],
            type: question['type'],
            correct: question['correct'],
            additionInfo: question['addition info'],
            clock: question['clock'],
          ))
      .toList();

  // expose to global use
  Animation get countdown => _countdown;
  int get currentPoint => _currentPoint;
  int get index => _index;
  int get result => _result;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // questionLength = sampleQuestions.length;

    _countdownController = AnimationController(
        duration: Duration(seconds: _questionList[index].clock), vsync: this);

    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController)
      ..addListener(() {
        // update = setState
        update();
      });

    super.onInit();
  }

  @override
  void onClose() {
    _countdownController.dispose();
    super.onClose();
  }

  void resetQuestionState() {
    // _countdownController = AnimationController(
    //     duration: Duration(seconds: _questionList[index].clock), vsync: this);
    // _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController)
    //   ..addListener(() {
    //     // update = setState
    //     update();
    //   });
    update();

    _countdownController.reset();
    _countdownController.forward();
  }

  void checkAnswer() {
    _currentPoint += 100;
  }

  void gotoQuestionTitle() {}

  void gotoPollPage() {
    resetQuestionState();

    Get.to(QuestionPollPage());
  }

  void gotoAnswerReveal() {
    _countdownController.stop();
    _index++;

    Get.to(AnswerRevealPage());
  }

  void gotoAnswerInfo() {}
}
