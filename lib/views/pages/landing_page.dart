import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/services/auth_service.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/pages/admin/test_firebase.dart';

import '../widgets/Layer.dart';
import '../widgets/TextFieldWithButton.dart';

class LandingPage extends StatefulWidget {
  static const routeName = "/";

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // bool _isLoggedIn = false;

  validateSignIn(value) async {
    var pin = await AuthService.signIn(value);

    if (pin != '') {
      print(pin);
      return true;
    } else {
      return false;
    }
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
    } else {
      print(pin);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
      child: Stack(children: <Widget>[
        Image.asset(
          'assets/images/BackGround.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Layer(),
        Planet(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(children: [
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment(0, -0.6),
                  child: Transform.scale(
                      scale: 1.2, child: Image.asset('assets/images/logo.png')),
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TextFieldWithButton(
                      validator: inputValidator,
                      updator: inputUpdator,
                      // routeName: TeamFormationPage.routeName,
                      routeName: TestFirebasePage.routeName,
                      failMsg: 'Wrong game code!',
                      successMsg: 'Game joined!',
                      isKeyboard: isKeyboard),
                ))
          ]),
        ),
      ]),
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
    anime.forward();
  }

  @override
  void didUpdateWidget(Planet oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 2);
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
