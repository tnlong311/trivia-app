import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trivia_app/services/auth_service.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';

import '../widgets/Layer.dart';
import '../widgets/TextFieldWithButton.dart';

class LandingPage extends StatefulWidget {
  static const routeName = "/";

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController anime;
  late Animation movement;

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    movement = Tween(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: anime, curve: Curves.easeInOutCubic));
  }

  void run_animation() {
    anime.reset();
    anime.forward();
  }

  @override
  void didUpdateWidget(LandingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 3);
  }

  @override
  void dispose() {
    anime.dispose();
    super.dispose();
  }

  inputValidator(value) {
    // print(_isLoggedIn);
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }

    return null;
  }

  inputUpdator(value) async {
    var pin = await AuthService.signIn(value);

    if (pin == null || pin == '') {
      return false;
    }
    // login success
    else {
      print(pin);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery
        .of(context)
        .viewInsets
        .bottom != 0;
    final viewHeight = MediaQuery
        .of(context)
        .size
        .height;
    final viewWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                final p1 = Image.asset(
                  'assets/images/planet.png',
                  fit: BoxFit.cover,
                );

                return Positioned(
                    top: viewHeight / 1.35,
                    left: (MediaQuery
                        .of(context)
                        .size
                        .width - 700) / 2.0,
                    child: Container(
                      width: 700,
                      child: Transform.rotate(
                          angle: -2.0 / 3.0 * pi * (movement.value) + pi * 0.4,
                          child: p1),
                    ));
              }),
          AnimatedBuilder(
              animation: anime,
              builder: (context, _) {
                final d = movement.value.toDouble();
                return
                  Positioned(
                    top: -40,
                    left: -d * 300,
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 2.0 / 4.0,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        color: Colors.white.withOpacity(-d + 1),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                );
              }),
          AnimatedBuilder(
              animation: anime,
              builder: (context, _) {
                final d = movement.value.toDouble();
                return
                  Positioned(
                    top: 0,
                    left: (viewWidth - 400) / 2.0 + (1 - d) * 350,
                    child: Container(
                      color: Colors.transparent,
                      width: 400,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.white.withOpacity(d),
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
                                      .withOpacity(d),
                                ),
                                Shadow(
                                  offset: const Offset(-4.0, -4.0),
                                  blurRadius: 1.0,
                                  color: const Color.fromARGB(255, 67, 230, 244)
                                      .withOpacity(d),
                                ),
                              ],
                              decoration: TextDecoration.none,
                            ), text: "How can we call your group?"),
                      ),
                    ),
                  );
              }),
          Positioned(
            top: viewHeight * 2.0 / 4.0 - max(0, MediaQuery.of(context).viewInsets.bottom - viewHeight * 2.0 / 4.0),
            left: (viewWidth - 250) / 2.0,
            child: TextFieldWithButton(
              validator: inputValidator,
              updator: inputUpdator,
              routeName: TeamFormationPage.routeName,
              failMsg: 'Wrong game code!',
              successMsg: 'Game joined!',
              hintText: 'Enter game code',
              isKeyboard: isKeyboard,
              width: 300,
              height: 80,
              run_animation: run_animation,
            ),
          ),
        ]),
      ),
    );
  }
}

class Planet extends StatefulWidget {
  const Planet({Key? key}) : super(key: key);

  @override
  State<Planet> createState() => _PlanetState();
}

class _PlanetState extends State<Planet> with TickerProviderStateMixin {
  late AnimationController anime;

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void didUpdateWidget(Planet oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 2);
    anime.forward();
  }

  @override
  void dispose() {
    anime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: anime,
        builder: (context, _) {
          final p1 = Image.asset(
            'assets/images/planet.png',
            fit: BoxFit.cover,
          );

          return Positioned(
              top: 600,
              left: -115,
              child: Transform.rotate(
                  angle: -2.0 / 3.0 * pi * (anime.value), child: p1));
        });
  }
}
