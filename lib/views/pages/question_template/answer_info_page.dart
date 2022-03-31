import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';

class AnswerInfoPage extends StatelessWidget {
  static const routeName = "/answer-info";

  const AnswerInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Navigator.pushNamed(context, QuestionTitlePage.routeName);
        },
      ),
    );
  }
}
