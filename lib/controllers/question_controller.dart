import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/models/mock_questions.dart';
import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';

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
  late int questionLength;

  final List<Question> questionList = sampleQuestions
      .map((question) => Question(
            id: question['id'],
            type: question['type'],
            correct: question['correct'],
            fullCorrect: question['full correct'],
            additionInfo: question['addition info'],
            clock: question['clock'],
          ))
      .toList();


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

    // _countdownController.dispose();

    _countdownController.duration =
        Duration(seconds: questionList[index].clock);
    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController);
    // update();

    // _countdownController.resync(this);
    _countdownController.reset();
    _countdownController.forward();
  }


  // routing
  void gotoQuestionTitle() {
    if (_index >= questionLength - 1) {
      _index = 0;
    } else {
      _index++;
    }

    Get.to(const QuestionTitlePage());
  }

  void gotoPollPage() {
    resetQuestionState();

    Get.to(QuestionPollPage());
  }

  void gotoAnswerReveal() {
    _countdownController.stop();

    Get.to(const AnswerRevealPage());
  }

  void gotoAnswerInfo() {
    Get.to(const AnswerInfoPage());
  }
}
