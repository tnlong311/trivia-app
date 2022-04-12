import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/widgets/InfoBox.dart';

import '../../../controllers/game_controller.dart';
import '../../../controllers/score_controller.dart';
import '../../widgets/CorrectAnswerWidget.dart';
import '../../widgets/Layer.dart';

class AnswerRevealPage extends StatelessWidget {
  static const routeName = "/answer-reveal";

  const AnswerRevealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreController _scoreController = Get.put(ScoreController());
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var boxHeight = screenWidth / 1.4 * 308 / 307;
    var box2Width = (screenWidth / 1.5 > 290) ? 290 : screenWidth / 1.5;
    var box2Height = box2Width * 207 / 290;
    var box3Width = (screenWidth / 1.6 > 218) ? 218 : screenWidth / 1.6;
    var box3Height = box3Width * 188 / 218;
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Layer(),
              Positioned(
                  top: screenHeight / 25,
                  left: (screenWidth - screenWidth / 1.4) / 2,
                  child: Container(
                    width: min(400, screenWidth / 1.4),
                    child: Image.asset(
                      'assets/images/Score_win_board.png',
                      fit: BoxFit.contain,
                    ),
                  )),
              Positioned(
                top: screenHeight / 25 + boxHeight / 3.8,
                left: (screenWidth - screenWidth / 1.4) / 2 + 20,
                child: Container(
                  width: screenWidth / 1.6 - 20,
                  height: boxHeight / 1.5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            width: boxHeight / 3.5,
                            child: Image.asset('assets/images/dogecoin.png')),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'YOU WIN', /// dien ket qua lose hay win nha a
                              style: triviaHeading1,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${_scoreController.totalPoint}", /// o day them cai so trong bang dau tien nha a
                              style: triviaHeading1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: screenHeight / 2 + 10,
                  left: 5,
                  child: Container(
                    width: screenWidth / 1.5,
                    height: box2Height,
                    alignment: Alignment.center,
                    color: Colors.black45,
                    child: Stack(
                      children: [
                        Container(
                          height: box2Height,
                          width: screenWidth / 1.5,
                          child: Image.asset('assets/images/Your_answer_panel.png'),
                          /// o day them answer nha a
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              _scoreController.resultString,
                              style: triviaHeading1,
                            ),
                            width: box2Width / 1.1,
                          ),
                        )
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 4,
                  right: 5,
                  child: Container(
                    height: screenHeight / 5,
                    width: screenWidth / 1.6,

                    child: Stack(children: [
                      Image.asset('assets/images/Current_score_panel.png'),
                      Positioned(
                        right: screenWidth / 1.6 - box3Width,
                        child: Container(
                          alignment: Alignment.center,
                          width: box3Width/1,
                          height: box3Height,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text( '1222', /// O day them diem nha anh
                              style: triviaHeading1,
                            ),
                          ),
                        ),
                      )
                    ]),
                  )),
            ],
          ),
        ));
  }
}