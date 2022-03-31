import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/landing_page.dart';

class RulesPage extends StatelessWidget {
  static const routeName = "/rules";
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('game rules here', style: triviaHeading2),
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('ho ho'),
          onPressed: () {
            Navigator.pushNamed(context, LandingPage.routeName);
          },
        ),
      ),
    );
  }
}