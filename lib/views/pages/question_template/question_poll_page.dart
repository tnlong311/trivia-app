import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:trivia_app/controllers/score_controller.dart';

import '../../../consts/app_styles.dart';
import '../../dialogs/custom_snackbar.dart';
import '../../dialogs/custom_spinner.dart';
import '../../widgets/Layer.dart';
import '../../widgets/ProgressBar.dart';
import '../../widgets/TextFieldSingle2.dart';

class QuestionPollPage extends StatefulWidget {
  static const routeName = "/question-poll";

  const QuestionPollPage({Key? key}) : super(key: key);

  @override
  State<QuestionPollPage> createState() => _QuestionPollPageState();
}

class _QuestionPollPageState extends State<QuestionPollPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final GameController _gameController = Get.put(GameController());
  final ScoreController _scoreController = Get.put(ScoreController());
  bool _isPressing = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final keyboard_height = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboard = keyboard_height != 0;
    GameController _gameController = Get.put(GameController());
    ScoreController _scoreController = Get.put(ScoreController());

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var box_width = screenWidth / 2.4;
    var box_height = box_width * 2 / 3;
    var pop_up = keyboard_height - (screenHeight - screenHeight / 2 - 20 - 75);
    var paddingTop = 70.0;

    final totalPoint = _scoreController.totalPoint;

    answerValidator(value) {
      print('trigger answer');
      String input = value.toString().trim();

      if (input.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    betValidator(value) {
      print('trigger bet');
      String input = value.toString().trim();

      if (input.isEmpty) {
        return 'Please enter a number';
      } else {
        var num = int.tryParse(input);
        if (num == null) {
          return 'Enter a valid number';
        } else if (num < 0) {
          return 'Must be positive ?? :D';
        } else if (_scoreController.totalPoint <= 0) {
          if (num > 1) {
            return 'Can bet 1 point';
          } else {
            return null;
          }
        } else if (num > (_scoreController.totalPoint / 2).ceil() &&
            _gameController.index + 1 < 11) {
          return 'Must not exceed half of your score';
        } else if (num > _scoreController.totalPoint &&
            _gameController.index + 1 > 10) {
          return 'Must not exceed your total score';
        }
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
      print('here on submit');
      // close keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      if (_formKey.currentState!.validate()) {
        setState(() {
          _isPressing = true;
        });
        await Future.delayed(Duration(seconds: 2));

        if (_gameController.countdown.isCompleted) {
          CustomSnackBar.showFailSnackBar(context, 'Out of time!');
        } else if (!_scoreController.isAnswered) {
          _scoreController.setAnswerState(true);
          _formKey.currentState!.save();
          if (await _scoreController.checkAndPostAnswer()) {
            CustomSnackBar.showSuccessSnackBar(context, 'Answer submitted!');
          } else {
            CustomSnackBar.showFailSnackBar(context, 'Submit failed!');
          }
        } else {
          CustomSnackBar.showFailSnackBar(context, 'Already submitted!');
        }

        setState(() {
          _isPressing = false;
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          top: false,
          child: WillPopScope(
            onWillPop: () async => false,
            child: GetBuilder<GameController>(
                init: GameController(),
                builder: (gameController) {
                  return Stack(children: <Widget>[
                    Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Layer(),
                    Positioned(
                      top: 0,
                      child: ProgressBar(
                          width: screenWidth,
                          progress: gameController.countdown.value),
                    ),
                    Positioned(
                      top: paddingTop,
                      right: (screenWidth / 2 - box_width) / 2,
                      child: Container(
                          width: box_width,
                          child:
                              Image.asset('assets/images/Time_left_box.png')),
                    ),
                    Positioned(
                      top: paddingTop,
                      left: (screenWidth / 2 - box_width) / 2,
                      child: Container(
                          width: box_width,
                          child: Image.asset(
                              'assets/images/current_point_box.png')),
                    ),
                    Positioned(
                        top: paddingTop + (box_height * 1.1 - 40) / 2,
                        right: (screenWidth / 2.0 - box_width) / 2.0 +
                            (box_width - 70) / 2.0 -
                            3,
                        child: Container(
                          width: 70,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: triviaSmall2,
                              text:
                                  '${(gameController.countdown.value * gameController.duration).round()}s',
                            ),
                          ),
                        )),
                    Positioned(
                        top: paddingTop + (box_height * 1.1 - 40) / 2,
                        left: (screenWidth / 2.0 - box_width) / 2.0 +
                            (box_width - 110) / 2.0 -
                            3,
                        child: Container(
                          width: 110,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: triviaSmall2,
                              text: '$totalPoint',
                            ),
                          ),
                        )),
                    Positioned(
                      top: screenHeight / 2 - 99 - (isKeyboard ? pop_up : 0),
                      left: (screenWidth - screenWidth / 1.4 * 0.8) / 2.0,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFieldSingle2(
                                isKeyboard: isKeyboard,
                                width: screenWidth / 1.4,
                                height: 69,
                                hintText: "ENTER ANSWERS",
                                validator: answerValidator,
                                updator: answerUpdator,
                                onEnter: answerOnSubmit),
                            const SizedBox(height: 30),
                            TextFieldSingle2(
                                isKeyboard: isKeyboard,
                                width: screenWidth / 1.4,
                                height: 69,
                                hintText: "ENTER BET",
                                validator: betValidator,
                                updator: betUpdator,
                                onEnter: answerOnSubmit),
                          ],
                        ),
                      ),
                    ),
                    _isPressing
                        ? Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Spinner.FadingCube(),
                          )
                        : Positioned(
                            left: (screenWidth - 200) / 2.0,
                            bottom: screenHeight / 5.5,
                            child: Container(
                                width: 200,
                                child: SubmitButton(onPressed: answerOnSubmit)),
                          ),
                  ]);
                }),
          )),
    );
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  var pd;

  @override
  void initState() {
    pd = Image.asset(
      'assets/images/button_not_pressed.png',
    );
  }

  @override
  void didUpdateWidget(SubmitButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          pd = Image.asset(
            'assets/images/button_pressed.png',
          );
        });
      },
      onTapCancel: () => {
        setState(() {
          pd = Image.asset(
            'assets/images/button_not_pressed.png',
          );
        })
      },
      onTapUp: (tap) async {
        setState(() {
          pd = Image.asset(
            'assets/images/button_not_pressed.png',
          );
        });
        await widget.onPressed();
      },
      child: pd,
    );
  }
}
