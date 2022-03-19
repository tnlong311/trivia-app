import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';

class QuestionPollPage extends StatefulWidget {
  static const routeName = "/question-poll";

  const QuestionPollPage({Key? key}) : super(key: key);

  @override
  State<QuestionPollPage> createState() => _QuestionPollPageState();
}

class _QuestionPollPageState extends State<QuestionPollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Text(
              "Question poll",
              style: Theme.of(context).textTheme.headline3,
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AnswerRevealPage.routeName);
        },
      ),
    );
  }
}
