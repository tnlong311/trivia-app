import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:trivia_app/controllers/score_controller.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';

import '../../dialogs/custom_snackbar.dart';
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
    GameController _gameController = Get.put(GameController());
    ScoreController _scoreController = Get.put(ScoreController());

    final totalPoint = _scoreController.totalPoint;

    answerValidator(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    betValidator(value) {
      var input = num.tryParse(value);

      if (input == null) {
        return 'Enter a valid number';
      } else if (input < 0) {
        return 'Must be positive ?? :D';
      } else if (input > _scoreController.totalPoint / 2 &&
          _gameController.index < 11) {
        return 'Must not exceed half of your score';
      } else if (input > _scoreController.totalPoint &&
          _gameController.index > 10) {
        return 'Must not exceed your total score';
      }
      return null;
    }

    answerUpdator(value) {
      _scoreController.setUserAnswer(value);
      // print(_scoreController.userAnswer);
    }

    betUpdator(value) {
      _scoreController.setBet(value);
      // print(_scoreController.bet);
    }

    answerOnSubmit() async {
      // close keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      if (_formKey.currentState!.validate()) {
        if (_gameController.countdown.isCompleted) {
          CustomSnackBar.showFailSnackBar(context, 'Out of time!');
        } else if (!_scoreController.isAnswered) {
          _scoreController.setAnswerState(true);
          _formKey.currentState!.save();
          await _scoreController.checkAndPostAnswer();
          CustomSnackBar.showSuccessSnackBar(context, 'Answer submitted!');
        } else {
          CustomSnackBar.showFailSnackBar(context, 'Already submitted!');
        }
      }
    }

    return Scaffold(
      body: SafeArea(
          child: GetBuilder<GameController>(
              init: GameController(),
              builder: (gameController) {
                return Column(
                  children: [
                    ProgressBar(progress: gameController.countdown.value),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InfoBox(
                            title: "Current Point",
                            width: 150,
                            height: 120,
                            content: '$totalPoint',
                          ),
                          InfoBox(
                            title: "Time Left",
                            width: 150,
                            height: 120,
                            content:
                                '${(gameController.countdown.value * gameController.duration).round()}s',
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
                                updator: answerUpdator,
                                onEnter: answerOnSubmit),
                            TextFieldSingle(
                                width: 250,
                                title: "Bet",
                                description: "Enter your bet...",
                                validator: betValidator,
                                updator: betUpdator,
                                onEnter: answerOnSubmit),
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
    );
  }
}
