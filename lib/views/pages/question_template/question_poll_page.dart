import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';

import '../../widgets/InfoBox.dart';

class QuestionPollPage extends StatefulWidget {
  static const routeName = "/question-poll";

  const QuestionPollPage({Key? key}) : super(key: key);

  @override
  State<QuestionPollPage> createState() => _QuestionPollPageState();
}

class _QuestionPollPageState extends State<QuestionPollPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                InfoBox(title: "Current Point", width: 150, height: 120,),
                InfoBox(title: "Time Left", width: 150, height: 120,),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SizedBox(height: 30),
                  TextFieldSingle(width: 250),
                  TextFieldSingle(width: 250)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                  },
                  child: Text(
                    "Submit",
                    style: themeData.textTheme.headline5,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AnswerRevealPage.routeName);
        },
      ),
    );
  }
}
