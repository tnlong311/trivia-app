import 'package:flutter/material.dart';

import 'landing_page.dart';

class GuidelinesPage extends StatelessWidget {
  static const routeName = "/guidelines";
  const GuidelinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App guidelines here'),
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('he he'),
          onPressed: () {
            Navigator.pushNamed(context, LandingPage.routeName);
          },
        ),
      ),
    );
  }
}