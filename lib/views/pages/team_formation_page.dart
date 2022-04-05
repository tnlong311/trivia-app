import 'package:flutter/material.dart';

import '../../consts/app_styles.dart';
import '../widgets/TextFieldWithButton.dart';
import 'lobby_page.dart';

class TeamFormationPage extends StatelessWidget {
  static const routeName = "/team-formation";

  const TeamFormationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/BackGround.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(style: triviaHeading1, children: [
                      TextSpan(text: "How can we\ncall your group?"),
                    ]),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: isKeyboard
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: TextFieldWithButton(
                          routeName: LobbyPage.routeName,
                          isKeyboard: isKeyboard),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ]);
  }
}
