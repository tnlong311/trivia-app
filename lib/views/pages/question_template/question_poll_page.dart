import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:trivia_app/controllers/question_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    QuestionController _questionController = Get.put(QuestionController());

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

    answerUpdator(value) {
      _questionController.setUserAnswer(value);
      // print(_questionController.userAnswer);
    }

    betUpdator(value) {
      _questionController.setBet(value);
      // print(_questionController.bet);
    }

    answerOnSubmit() {
      if (_formKey.currentState!.validate()) {
        // update state to Controller
        _formKey.currentState!.save();
        _questionController.checkAnswer();
        // _questionController.resetQuestionState();
      }
    }

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
                            content: '${(controller.countdown.value*controller.duration).round()}s',
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
                                updator: answerUpdator),
                            TextFieldSingle(
                                width: 250,
                                title: "Bet",
                                description: "Enter your bet...",
                                validator: betValidator,
                                updator: betUpdator),
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
                            onPressed: answerOnSubmit,
                            child: Text(
                              "Submit",
                              style: themeData.textTheme.headline5,
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
          _questionController.gotoAnswerInfo();
        },
      ),
    );
  }
}

