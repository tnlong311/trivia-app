import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:trivia_app/controllers/score_controller.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';

import '../../../consts/app_styles.dart';
import '../../widgets/InfoBox.dart';
import '../../widgets/Layer.dart';
import '../../widgets/ProgressBar.dart';

class QuestionPollPage extends StatefulWidget {
  static const routeName = "/question-poll";

  const QuestionPollPage({Key? key}) : super(key: key);

  @override
  State<QuestionPollPage> createState() => _QuestionPollPageState();
}

class _QuestionPollPageState extends State<QuestionPollPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final keyboard_height = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    GameController _gameController = Get.put(GameController());
    ScoreController _scoreController = Get.put(ScoreController());

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
      _scoreController.setUserAnswer(value);
      // print(_gameController.userAnswer);
    }

    betUpdator(value) {
      _scoreController.setBet(value);
      // print(_gameController.bet);
    }

    answerOnSubmit() {
      if (_formKey.currentState!.validate()) {
        // calls updator()
        _formKey.currentState!.save();
        _scoreController.checkAnswer();
        // _gameController.resetQuestionState();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: GetBuilder<GameController>(
              init: GameController(),
              builder: (gameController) {
                return Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/BackGround.png',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Layer(),
                    Positioned(
                      top: 50,
                      right:
                          (MediaQuery.of(context).size.width / 2.0 - 200) / 2.0,
                      child: Container(
                          width: 200,
                          child:
                              Image.asset('assets/images/Time_left_box.png')),
                    ),
                    Positioned(
                      top: 50,
                      left:
                          (MediaQuery.of(context).size.width / 2.0 - 200) / 2.0,
                      child: Container(
                          width: 200,
                          child: Image.asset(
                              'assets/images/current_point_box.png')),
                    ),
                    Positioned(
                        top: 105,
                        right: (MediaQuery.of(context).size.width / 2.0 - 200) /
                                2.0 +
                            (200 - 70) / 2.0 -
                            3,
                        child: Container(
                          width: 70,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(style: triviaSmall2, text: "1234"),
                          ),
                        )),
                    Positioned(
                        top: 105,
                        left: (MediaQuery.of(context).size.width / 2.0 - 200) /
                                2.0 +
                            (200 - 70) / 2.0 -
                            3,
                        child: Container(
                          width: 70,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(style: triviaSmall2, text: "1234"),
                          ),
                        )),
                    Positioned(
                        top: (MediaQuery.of(context).size.height - keyboard_height) / 2.0,
                        child: Text('Hello', style: triviaHeading2,)),
                    TextFormField(
                      style: triviaSmall1,

                      controller: _controller,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 8, left: 15),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 5.0),
                        ),
                        hintText: 'Enter game code',
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
