import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/controllers/score_controller.dart';
import 'package:trivia_app/views/pages/end_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';

import '../models/question.dart';
import '../utils/custom_routing.dart';

class GameController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _countdownController;
  late Animation _countdown;
  final List<Question> _questionList = [];
  int _index = 0;

  // getters
  Animation get countdown => _countdown;

  int get index => _index;

  int get duration => _questionList[index].clock;

  int get questionsLength => _questionList.length;

  // helpful methods
  Future<void> fetchQuestions() async {
    DatabaseReference questionRef =
        FirebaseDatabase.instance.ref().child('/game bank/2022/questions');

    await questionRef
        .get()
        .then((DataSnapshot snapshot) {
          for (var q in (snapshot.value as List)) {
            if (q != null) {
              Question question = Question.fromRTDB(q);
              _questionList.add(question);
            }
          }
        })
        .then((_) => print('question list fetched'))
        .catchError((error) => print(error));
  }

  Future<void> resetQuestionState() async {
    print("index $index, timer: ${_questionList[index].clock}");

    updateCountDown();
    _countdownController.reset();

    ScoreController _scoreController = Get.put(ScoreController());
    await _scoreController.resetAnswerState();
  }

  void setIndexFromQuestionNum(value) {
    // _index = await RtdbGameService.getCurrentIndex();
    _index = value - 1;
    update();
    ScoreController _scoreController = Get.put(ScoreController());
    _scoreController.setIndex(_index);
  }

  void updateCountDown() {
    _countdownController.duration =
        Duration(seconds: _questionList[index].clock);
    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController);
    update();
  }

  // page 1
  Future<void> gotoQuestionTitle() async {
    if (_index >= questionsLength) {
      Get.offAndToNamed(EndPage.routeName);
    } else {
      CustomRouter.customGetTo(const QuestionTitlePage());
      await Future.delayed(const Duration(seconds: 2), () {
        gotoPollPage();
      });
    }
  }

  // page 2
  Future<void> gotoPollPage() async {
    await resetQuestionState();

    CustomRouter.customGetTo(const QuestionPollPage());

    _countdownController.forward();
  }

  // page 3
  void gotoAnswerReveal() {
    CustomRouter.customGetTo(const AnswerRevealPage());
  }

  // called immediately after the widget is allocated memory
  @override
  void onInit() async {
    super.onInit();

    await fetchQuestions();

    // countdown
    _countdownController =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);

    _countdown = Tween<double>(begin: 1, end: 0).animate(_countdownController)
      ..addListener(() {
        // update = setState
        update();
      });
  }

  @override
  void onClose() {
    print("QuestionController closed");
    _countdownController.dispose();
    super.onClose();
  }
}
