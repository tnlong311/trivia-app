import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';

class QuestionTitlePage extends StatelessWidget {
  static const routeName = "/question-title";

  const QuestionTitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "Question #1",
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
