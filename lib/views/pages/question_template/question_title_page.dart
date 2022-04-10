import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/game_controller.dart';
import '../../widgets/Layer.dart';

class QuestionTitlePage extends StatefulWidget {
  static const routeName = "/question-title";

  const QuestionTitlePage({Key? key}) : super(key: key);

  @override
  State<QuestionTitlePage> createState() => _QuestionTitlePageState();
}

class _QuestionTitlePageState extends State<QuestionTitlePage>
    with TickerProviderStateMixin {
  late AnimationController anime;

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    Future.delayed(const Duration(seconds: 10));
    anime.repeat(reverse: true);
  }

  void run_animation() {
    anime.reset();
    anime.forward();
  }

  @override
  void didUpdateWidget(QuestionTitlePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 6);
  }

  @override
  void dispose() {
    anime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    GameController _gameController = Get.put(GameController());

    return Scaffold(
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
          AnimatedBuilder(
            animation: anime,
            builder: (context, _) {
              return Positioned(
                top: (MediaQuery.of(context).size.height - 100) / 2.0,
                left: (MediaQuery.of(context).size.width - 400) / 2.0 +
                    max(0, anime.value * 6 - 4) / 2 * 400,
                child: Container(
                  color: Colors.white30,
                  width: 400,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          color: Colors.white.withOpacity(
                              max(0, 1 - max(0, anime.value * 6 - 4))),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'PixelFont',
                          letterSpacing: 0.6,
                          fontSize: 50,
                          height: 2,
                          shadows: <Shadow>[
                            Shadow(
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 1.0,
                              color: const Color.fromARGB(255, 232, 27, 119)
                                  .withOpacity(
                                      max(0, 1 - max(0, anime.value * 6 - 4))),
                            ),
                            Shadow(
                              offset: const Offset(-4.0, -4.0),
                              blurRadius: 1.0,
                              color: const Color.fromARGB(255, 67, 230, 244)
                                  .withOpacity(
                                      max(0, 1 - max(0, anime.value * 6 - 4))),
                            ),
                          ],
                          decoration: TextDecoration.none,
                        ),
                        text: "Question #${_gameController.index + 1}"),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
