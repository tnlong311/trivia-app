import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/widgets/TextFieldWithButton.dart';
import 'package:trivia_app/views/widgets/test.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  static const routeName = "/";

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Center(
                child: RichText(
                  text: const TextSpan(style: triviaHeading1, children: [
                    TextSpan(text: "Welcome to\n"),
                    TextSpan(
                      text: "Trivia Night\n",
                    ),
                    TextSpan(text: "with STEM club!", style: triviaHeading2),
                  ]),
                ),
              )),
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
    );
  }
}
