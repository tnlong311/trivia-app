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
  String answer = '';
  String bet = '';

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
                InfoBox(
                  title: "Current Point",
                  width: 150,
                  height: 120,
                  content: "1234",
                ),
                InfoBox(
                  title: "Time Left",
                  width: 150,
                  height: 120,
                  content: '20s',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 30),
                  TextFieldSingle(
                      width: 250,
                      title: "Answer",
                      description: "Enter your answer...",
                      validator: answerValidator,
                  input: answer),
                  TextFieldSingle(
                      width: 250,
                      title: "Bet",
                      description: "Enter your bet...",
                      validator: betValidator,
                  input: bet),
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
                    if(_formKey.currentState!.validate()){
                      print('your answer is submitted');
                      _formKey.currentState!.save();
                    };
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

answerValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

betValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }
  return null;
}
