import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/widgets/TextFieldWithButton.dart';

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

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
      child: Stack(children: <Widget>[
        Image.asset(
          'assets/images/sky.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
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
                ))
          ]),
        )
      ]),
    );
  }
}
