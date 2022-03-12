import 'package:flutter/material.dart';

import 'lobby_page.dart';

class TeamFormationPage extends StatelessWidget {
  static const routeName = "/team-formation";
  const TeamFormationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter team name'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Next page'),
          onPressed: () {
            Navigator.pushNamed(context, LobbyPage.routeName);
          },
        ),
      ),
    );
  }
}