import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/views/dialogs/Rules_content.dart';

import '../../consts/app_styles.dart';
import '../widgets/Layer.dart';

class LobbyPage extends StatefulWidget {
  static const routeName = "/lobby";

  const LobbyPage({Key? key}) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final slideList = [WaitingRoom(), GuidelinesPage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: slideList.length,
            itemBuilder: (context, i) => slideList[i],
          ),
        ));
  }
}

class WaitingRoom extends StatefulWidget {
  const WaitingRoom({Key? key}) : super(key: key);

  @override
  State<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom>
    with TickerProviderStateMixin {
  late AnimationController anime;

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));
    anime.repeat();
  }

  void run_animation() {
    anime.reset();
    anime.forward();
  }

  @override
  void didUpdateWidget(WaitingRoom oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 4);
  }

  @override
  void dispose() {
    anime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final viewHeight = MediaQuery.of(context).size.height;
    final viewWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async => false,
          child: Stack(children: <Widget>[
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: const Text(
                'Swipe right ->',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'PixelFont',
                  letterSpacing: 0.6,
                  fontSize: 20,
                  height: 2,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const Layer(),
            Positioned(
              top: 0,
              left: (viewWidth - viewWidth / 1.2) / 2.0,
              child: Container(
                color: Colors.transparent,
                width: viewWidth / 1.2,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: triviaHeading2, text: "Waiting for host..."),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: anime,
                builder: (context, _) {
                  var p1 = Image.asset(
                    'assets/images/planet.png',
                    fit: BoxFit.cover,
                  );
                  final mv = anime.value.toDouble();
                  return Positioned(
                      top: viewHeight / 1.35,
                      left: (viewWidth - viewWidth / 1.1) / 2.0,
                      child: Container(
                          width: viewWidth / 1.1,
                          child: Transform.translate(
                            offset: Offset(0, -viewHeight / 3),
                            child: Transform.rotate(
                                angle: -2.0 / 3.0 * pi * 1 +
                                    pi * 0.4 -
                                    2 * pi * mv,
                                child: p1),
                          )));
                }),
          ]),
        ),
      ),
    );
  }
}

class GuidelineNav extends StatelessWidget {
  const GuidelineNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.cyanAccent),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, GuidelinesPage.routeName);
                },
                child: const Text(
                  "App guidelines",
                  style: triviaHeading1,
                  textAlign: TextAlign.center,
                ))));
  }
}

class GuidelinesPage extends StatefulWidget {
  static const routeName = "/rules";

  const GuidelinesPage({Key? key}) : super(key: key);

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  var backGroundLink;
  var pageCounter = 0;
  var textContent;
  List<String> framePages = [
    'assets/images/Rule_page.png',
    'assets/images/About_TV.png',
    'assets/images/About_app.png',
  ];
  List<Text> content = [rules_trivia, about_trivia, about_app];

  @override
  void initState() {
    backGroundLink = 'assets/images/Rule_page.png';
    pageCounter = 0;
    textContent = content[pageCounter];
  }

  @override
  void didUpdateWidget(GuidelinesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    backGroundLink = framePages[pageCounter];
    textContent = content[pageCounter];
  }

  void incre() {
    setState(() {
      pageCounter = (pageCounter + 1) % 3;
      backGroundLink = framePages[pageCounter];
      textContent = content[pageCounter];
    });
  }

  void decre() {
    setState(() {
      pageCounter = (pageCounter - 1 + 3) % 3;
      backGroundLink = framePages[pageCounter];
      textContent = content[pageCounter];
    });
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
    if (max(0, 375 - screenWidth / 1.1) / 375 > max(0, 812 - screenHeight / 1.1) / 812) {
      realWidth = screenWidth / 1.1;
      realHeight = realWidth / ratio;
    } else {
      realHeight = screenHeight / 1.1;
      realWidth = realHeight * ratio;
    }
    var heightSpace = max(0, screenHeight / 1.1 - realHeight) / 2;
    double border_ratio = (MediaQuery.of(context).size.height / 1.1) / 812.0;

    var scaleRatio = (screenWidth / 1.1 >= 375.0)
        ? 1.1
        : ((screenHeight / 1.1) * ratio / 375.0);
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
            Container(
              alignment: Alignment.center,
              child: Container(
                height: screenHeight / 1.1,
                width: screenWidth / 1.1,
                color: Colors.black45,
                child: Stack(children: [
                  Container(
                    child: Container(
                      height: screenHeight / 1.1,
                      width: screenWidth / 1.1,
                      child: Image.asset(framePages[pageCounter]),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: (realWidth / 2.5) / 2 * (30 / 80) +
                          realHeight / 49 +
                          heightSpace,
                      width: realWidth / 2.5 + borderSpace + realWidth / 20,
                      child: Container(
                        width: realWidth / 2.5,
                        height: (realWidth / 2.5) / 2 * (30 / 80),
                        color: Colors.transparent,
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                width: (realWidth / 2.5) / 2,
                                child: NextButton(
                                  upd: incre,
                                  scale_factor: 1.0,
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                width: (realWidth / 2.5) / 2,
                                child: BackButton(
                                  upd: decre,
                                )),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, 0.2),
                    child: Container(
                      height: realHeight / 1.35,
                      width: realWidth / 1.3,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: textContent,
                      ),
                    ),
                  ),

                ]),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  final scale_factor;
  final Function upd;

  NextButton({Key? key, this.scale_factor, required this.upd})
      : super(key: key);

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

        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            pd = Image.asset(
              'assets/images/next_page_not_pressed.png',
              height: 38 * d,
            );
          });
        });
      },
      child: pd,
    );
  }
}

class BackButton extends StatefulWidget {
  final Function upd;

  BackButton({Key? key, required this.upd}) : super(key: key);

  @override
  State<BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  var pd;

  @override
  void initState() {
    pd = Image.asset(
      'assets/images/previous_page_not_pressed.png',
      height: 38,
      fit: BoxFit.contain,
    );
  }

  @override
  void didUpdateWidget(BackButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          pd = Image.asset(
            'assets/images/previous_page_pressed.png',
            height: 38,
          );
        });
      },
      onTapCancel: () => {
        setState(() {
          pd = Image.asset(
            'assets/images/previous_page_not_pressed.png',
            height: 38,
          );
        })
      },
      onTapUp: (tap) {
        widget.upd();
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            pd = Image.asset(
              'assets/images/previous_page_not_pressed.png',
              height: 38,
            );
          });
        });
      },
      child: pd,
    );
  }
}
