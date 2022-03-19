import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';

class AnswerRevealPage extends StatelessWidget {
  static const routeName = "/answer-reveal";

  const AnswerRevealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Text(
              "Your correct answer is...",
              style: Theme.of(context).textTheme.headline3,
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AnswerInfoPage.routeName);
        },
      ),
    );
  }
}
