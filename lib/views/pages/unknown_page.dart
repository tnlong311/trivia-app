import 'package:flutter/material.dart';

import 'landing_page.dart';

class UnknownPage extends StatelessWidget {
  static const routeName = "";
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('404 not found'),
          onPressed: () {
            Navigator.pushNamed(context, LandingPage.routeName);
          },
        ),
      ),
    );
  }
}