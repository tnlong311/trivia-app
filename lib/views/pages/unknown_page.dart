import 'package:flutter/material.dart';

import '../../consts/app_styles.dart';
import '../widgets/Layer.dart';
import 'landing_page.dart';

class UnknownPage extends StatelessWidget {
  static const routeName = "";

  const UnknownPage({Key? key}) : super(key: key);

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
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, LandingPage.routeName),
                    },
                    child: Container(
                        width: viewWidth / 1.3,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: '404 not found',
                            style: triviaHeading2,
                          ),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
