import 'dart:math';

import 'package:flutter/material.dart';

// import 'package:flutter/rendering.dart';
import '../widgets/Layer.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/landing_page.dart';

class RulesPage extends StatefulWidget {
  static const routeName = "/rules";

  const RulesPage({Key? key}) : super(key: key);

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  var backGroundLink;
  var pageCounter = 0;
  List<String> framePages = [
    'assets/images/Rule_page.png',
    'assets/images/About_TV.png',
    'assets/images/About_app.png',
  ];

  @override
  void initState() {
    backGroundLink = 'assets/images/Rule_page.png';
    pageCounter = 0;
  }

  @override
  void didUpdateWidget(RulesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    backGroundLink = framePages[pageCounter];
  }

  void incre() {
    setState(() {
      pageCounter = (pageCounter + 1) % 3;
      backGroundLink = framePages[pageCounter];
    });
  }

  void decre() {
    setState(() {
      pageCounter = (pageCounter - 1 + 3) % 3;
      backGroundLink = framePages[pageCounter];
    });
    print(backGroundLink);

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double ratio = 375.0 / 812.0;
    var borderSpace =
        max(0, screenWidth / 1.1 - (screenHeight / 1.1) * ratio) / 2;
    var realWidth = (screenWidth / 1.1 >= 375.0) ? 375.0 : (screenWidth / 1.1);
    var realHeight = realWidth / ratio;
    var heightSpace = max(0, screenHeight / 1.1 - realHeight) / 2;

    var scaleRatio = (screenWidth / 1.1 >= 375.0)
        ? 1.1
        : ((screenHeight / 1.1) * ratio / 375.0);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/BackGround.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Layer(),
            Positioned(
              top: (screenHeight - screenHeight / 1.1) / 2.0,
              left: (screenWidth - screenWidth / 1.1) / 2.0,
              child: Container(
                color: Colors.black38,
                height: screenHeight / 1.1,
                width: screenWidth / 1.1,
                child: Image.asset(
                  framePages[pageCounter],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: (screenHeight - screenHeight / 1.1) / 2.0 +
                  heightSpace +
                  realHeight / 63,
              right: (screenWidth - screenWidth / 1.1) / 2.0 +
                  borderSpace +
                  realWidth / 30,
              child: Container(
                width: realWidth / 2.5,
                height: (realWidth / 2.5) / 2 * (30 / 80),
                color: Colors.transparent,
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        width: (realWidth / 2.5) / 2,
                        child: NextButton(
                          upd: incre,
                          scale_factor: 1,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: (realWidth / 2.5) / 2,
                        child: BackButton(
                          upd: decre,
                          scale_factor: 1,
                        )),
                  ),
                ]),
              ),
            ),
            // Positioned(
            //   top: 130 * border_ratio,
            //   left: (MediaQuery.of(context).size.width - 400) / 2.0 + border_space + 4 * border_ratio,
            //   child: Container(
            //     color: Colors.white,
            //     height: MediaQuery.of(context).size.height/1.3,
            //     width: 400 - border_space * 2 - 8 * border_ratio,
            //     child: const SingleChildScrollView(
            //         scrollDirection: Axis.vertical,
            //         child: Text(
            //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            //               'sed do eiusmod tempor incididunt ut labore et dolore '
            //               'magna aliqua. Ut enim ad minim veniam, quis nostrud '
            //               'exercitation ullamco laboris nisi ut aliquip ex ea '
            //               'commodo consequat. Duis aute irure dolor in '
            //               'reprehenderit in voluptate velit esse cillum dolore eu '
            //               'fugiat nulla pariatur. Excepteur sint occaecat cupidatat '
            //               'non proident, sunt in culpa qui officia deserunt mollit '
            //               'anim id est laborum.''Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
            //               'sed do eiusmod tempor incididunt ut labore et dolore '
            //               'magna aliqua. Ut enim ad minim veniam, quis nostrud '
            //               'exercitation ullamco laboris nisi ut aliquip ex ea '
            //               'commodo consequat. Duis aute irure dolor in '
            //               'reprehenderit in voluptate velit esse cillum dolore eu '
            //               'fugiat nulla pariatur. Excepteur sint occaecat cupidatat '
            //               'non proident, sunt in culpa qui officia deserunt mollit '
            //               'anim id est laborum.', style: triviaSmall1,)
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  final scale_factor;
  final Function upd;

  NextButton({Key? key, this.scale_factor, required this.upd}) : super(key: key);

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  var d = 0.0;
  var pd;

  @override
  void initState() {
    d = widget.scale_factor;
    pd = Image.asset(
      'assets/images/next_page_not_pressed.png',
      height: 38 * d,
      fit: BoxFit.contain,
    );
  }

  @override
  void didUpdateWidget(NextButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    d = widget.scale_factor;
    pd = Image.asset(
      'assets/images/next_page_not_pressed.png',
      height: 38 * d,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          pd = Image.asset(
            'assets/images/next_page_pressed.png',
            height: 38 * d,
          );
        });
      },
      onTapCancel: () => {
        setState(() {
          pd = Image.asset(
            'assets/images/next_page_not_pressed.png',
            height: 38 * d,
          );
        })
      },
      onTapUp: (tap) {
        widget.upd();
        setState(() {
          pd = Image.asset(
            'assets/images/next_page_not_pressed.png',
            height: 38 * d,
          );
        });
      },
      child: pd,
    );
  }
}

class BackButton extends StatefulWidget {
  final scale_factor;
  final Function upd;

  BackButton({Key? key, this.scale_factor, required this.upd}) : super(key: key);

  @override
  State<BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  var d = 0.0;
  var pd;

  @override
  void initState() {
    d = widget.scale_factor;
    pd = Image.asset(
      'assets/images/previous_page_not_pressed.png',
      height: 38 * d,
      fit: BoxFit.contain,
    );
  }

  @override
  void didUpdateWidget(BackButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    d = widget.scale_factor;
    pd = Image.asset(
      'assets/images/previous_page_not_pressed.png',
      height: 38 * d,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          pd = Image.asset(
            'assets/images/previous_page_pressed.png',
            height: 38 * d,
          );
        });
      },
      onTapCancel: () => {
        setState(() {
          pd = Image.asset(
            'assets/images/next_page_not_pressed.png',
            height: 38 * d,
          );
        })
      },
      onTapUp: (tap) {
        widget.upd();
        setState(() {
          pd = Image.asset(
            'assets/images/previous_page_not_pressed.png',
            height: 38 * d,
          );
        });
      },
      child: pd,
    );
  }
}
