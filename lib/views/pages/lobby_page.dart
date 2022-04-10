import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/guidelines_page.dart';
import 'package:trivia_app/views/pages/rules_page.dart';

import '../../consts/app_styles.dart';
import '../widgets/Layer.dart';

class LobbyPage extends StatefulWidget{
  static const routeName = "/lobby";
  const LobbyPage ({Key? key}) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> with TickerProviderStateMixin {
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
  void didUpdateWidget(LobbyPage oldWidget) {
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
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async => false,
          child: Stack(children: <Widget>[
            Image.asset(
              'assets/images/BackGround.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            const Layer(),
            Positioned(
              top: 0,
              left: (viewWidth - 400) / 2.0,
              child: Container(
                color: Colors.transparent,
                width: 400,
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
                      left: (viewWidth - 700 + 300) / 2.0,
                      child: Container(
                          width: 400,
                          child: Transform.translate(
                            offset: const Offset(0, -300),
                            child: Transform.rotate(
                                angle: -2.0 / 3.0 * pi * 1 + pi * 0.4 - 2 * pi * mv, child: p1),
                          )));
                }),
          ]),
        ),
      ),
    );
  }
}

const slideList = [WaitingInfo(), RulesNav(), GuidelineNav()];

class WaitingInfo extends StatelessWidget{
  const WaitingInfo ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.deepPurple
      ),
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: const Center(
        child: Text("Waiting for host to start the game...",
          style: triviaHeading2,
          textAlign: TextAlign.center,
        )
      )
    );
  }
}

class RulesNav extends StatelessWidget{
  const RulesNav ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.amberAccent
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
            child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, RulesPage.routeName);
                },
                child: const Text("Game rules",
                    style: triviaHeading1,
                    textAlign: TextAlign.center,
                    )
            )
        )
    );
  }
}

class GuidelineNav extends StatelessWidget{
  const GuidelineNav ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
      decoration: const BoxDecoration(
          color: Colors.cyanAccent
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Center(
          child: TextButton(
              onPressed: (){
                Navigator.pushNamed(context, GuidelinesPage.routeName);
              },
              child: const Text("App guidelines",
                style: triviaHeading1,
                textAlign: TextAlign.center,
              )
          )
      )
  );
  }
}