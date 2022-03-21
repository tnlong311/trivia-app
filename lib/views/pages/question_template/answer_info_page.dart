import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/question_controller.dart';

class AnswerInfoPage extends StatelessWidget {
  static const routeName = "/answer-info";

  const AnswerInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());

    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Text(
              "Some funfacts about this quesiton",
              style: Theme.of(context).textTheme.headline3,
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _questionController.gotoQuestionTitle();
        },
      ),
    );
  }
}
