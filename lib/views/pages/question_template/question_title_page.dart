import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';

import '../../../controllers/QuestionController.dart';

class QuestionTitlePage extends StatelessWidget {
  static const routeName = "/question-title";

  const QuestionTitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "Question #${_questionController.index}",
          style: Theme.of(context).textTheme.headline3,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, QuestionPollPage.routeName);
        },
      ),
    );
  }
}
