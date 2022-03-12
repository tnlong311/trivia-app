import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/guidelines_page.dart';
import 'package:trivia_app/views/pages/rules_page.dart';

import '../../consts/app_styles.dart';

class LobbyPage extends StatelessWidget{
  static const routeName = "/lobby";
  const LobbyPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
            flex: 2,
            child: WaitingInfo()
        ),
        Expanded(
          flex: 1,
            child: RulesNav()
        ),
        Expanded(
            child: GuidelineNav()
        ),
      ],
    );
  }
}

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