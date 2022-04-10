import 'package:flutter/material.dart';

class EndPage extends StatelessWidget {
  static const routeName = "/end";

  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: Text('Thank you for playing!'),
          ),
        ),
      ),
    );
  }
}
