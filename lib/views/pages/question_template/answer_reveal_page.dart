import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/views/widgets/InfoBox.dart';

import '../../../controllers/game_controller.dart';
import '../../../controllers/score_controller.dart';
import '../../widgets/CorrectAnswerWidget.dart';

class AnswerRevealPage extends StatelessWidget {
  static const routeName = "/answer-reveal";

  const AnswerRevealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreController _scoreController = Get.put(ScoreController());

    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                    child: InfoBox(
                        title: "",
                        width: 200,
                        height: 120,
                        content: _scoreController.resultString)),
              ),
              Expanded(
                flex: 1,
                child: CorrectAnswerWidget(
                    header: "The correct answer is:",
                    content: _scoreController.fullCorrectAnswer),
              ),
              Expanded(
                flex: 1,
                child: CorrectAnswerWidget(
                    header: "Your current point:",
                    content: _scoreController.totalPoint.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
