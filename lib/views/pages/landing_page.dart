import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/widgets/TextFieldWithButton.dart';

class LandingPage extends StatefulWidget {
  static const routeName = "/";
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _State();
}

class _State extends State<LandingPage> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery
        .of(context)
        .viewInsets
        .bottom != 0;

    return SafeArea(child: Stack(children: <Widget>[
      AnimatedBuilder(
          animation: _animationController,
          child: Image.asset('assets/images/sky.jpg'),
          builder: (context, child) =>
              Transform.scale(
                scale: _animationController.value,
                child: child,
              )),

      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset('assets/images/welcome.png'))),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TextFieldWithButton(
                      routeName: TeamFormationPage.routeName,
                      isKeyboard: isKeyboard),
                )),
          ],
        ),
      ),
      const Align(alignment: Alignment.center,
          child: Text('Hello', style: triviaHeading1)),
    ]));
  }
}