import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trivia_app/views/widgets/InfoBox.dart';

import '../../../controllers/game_controller.dart';
import '../../widgets/CorrectAnswerWidget.dart';

class AnswerRevealPage extends StatelessWidget {
  static const routeName = "/answer-reveal";

  const AnswerRevealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameController _gameController = Get.put(GameController());

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
                child: InfoBox(
                    title: "", width: 200, height: 120, content: _gameController.resultString)),
          ),
          Expanded(
            flex: 1,
            child: CorrectAnswerWidget(header: "The correct answer is:", content: _gameController.fullCorrectAnswer),
          ),
          Expanded(
            flex: 1,
            child: CorrectAnswerWidget(header: "Your current point:", content: _gameController.currentPoint.toString()),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gameController.gotoQuestionTitle();
        },
      ),
    );
  }
}
