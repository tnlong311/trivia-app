import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trivia_app/consts/app_styles.dart';

import '../../../controllers/game_controller.dart';

class AnswerInfoPage extends StatelessWidget {
  static const routeName = "/answer-info";

  const AnswerInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameController _gameController = Get.put(GameController());

    return Scaffold(
      body: const SafeArea(
          child: Center(
            child: Text(
              "Some funfacts about this quesiton",
              style: triviaHeading1,
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gameController.gotoAnswerReveal();
        },
      ),
    );
  }
}
