import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/controllers/question_controller.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';

import '../../widgets/InfoBox.dart';
import '../../widgets/ProgressBar.dart';

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
    QuestionController _questionController = Get.put(QuestionController());

    return Scaffold(
      body: SafeArea(
          child: GetBuilder<QuestionController>(
              init: QuestionController(),
              builder: (controller) {
                return Column(
                  children: [
                    ProgressBar(progress: controller.countdown.value),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InfoBox(
                            title: "Current Point",
                            width: 150,
                            height: 120,
                            content: '${controller.currentPoint}',
                          ),
                          InfoBox(
                            title: "Time Left",
                            width: 150,
                            height: 120,
                            content:
                                '${(controller.countdown.value * 30).round()}s',
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
                              _questionController.resetQuestionState();
                              _questionController.checkAnswer();
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                              ;
                            },
                            child: const Text(
                              "Submit",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
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
