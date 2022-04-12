import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';

import '../widgets/Layer.dart';

class EndPage extends StatelessWidget {
  static const routeName = "/end";

  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewHeight = MediaQuery.of(context).size.height;
    final viewWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                const Layer(),
                Positioned(
                    top: 100,
                    left: (viewWidth - viewWidth / 1.3) / 2,
                    child: Container(
                        width: viewWidth / 1.3,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: 'Thank you for playing',
                            style: triviaHeading2,
                          ),
                        ))),
              ],
            )),
      ),
    );
  }
}
