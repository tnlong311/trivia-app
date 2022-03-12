import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';

class LandingPage extends StatelessWidget {
  static const routeName = "/";
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing page here'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Next page'),
          onPressed: () {
            Navigator.pushNamed(context, TeamFormationPage.routeName);
          },
        ),
      ),
    );
  }
}