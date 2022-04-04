import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';

import '../../../controllers/game_controller.dart';
import '../../../controllers/score_controller.dart';

class QuestionTitlePage extends StatelessWidget {
  static const routeName = "/question-title";

  const QuestionTitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameController _gameController = Get.put(GameController());
    ScoreController _scoreController = Get.put(ScoreController());

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "Question #${_gameController.index+1}",
          style: triviaHeading1,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gameController.gotoPollPage();
        },
      ),
    );
  }
}
