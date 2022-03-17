import 'package:flutter/material.dart';

import '../../consts/app_styles.dart';
import '../widgets/CustomTextField1.dart';
import 'lobby_page.dart';

class TeamFormationPage extends StatelessWidget {
  static const routeName = "/team-formation";
  const TeamFormationPage({Key? key}) : super(key: key);

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
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: triviaHeading1,
                      children: [
                        TextSpan(text: "How can we\ncall your group?"),
                      ]
                  ),
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: CustomTextField1(
                    routeName: LobbyPage.routeName,
                    isKeyboard: isKeyboard),
              )
          )
        ],
      ),
    );
  }
}