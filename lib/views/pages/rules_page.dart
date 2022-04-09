import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/landing_page.dart';

class RulesPage extends StatefulWidget {
  static const routeName = "/rules";
  const RulesPage({Key? key}) : super(key: key);

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    double border_ratio = (MediaQuery.of(context).size.height / 1.1) / 812.0;
    double height_ratio = 1.0;
    var border_space = (400 - 357 * border_ratio) / 2.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/BackGround.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height / height_ratio) /
                2.0,
            left: (MediaQuery.of(context).size.width - 400) / 2.0,
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height / height_ratio,
              width: 400,
              child: Image.asset(
                'images/background_tab_back.png',
              ),
            ),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height / height_ratio) /
                2.0 +
                54 * border_ratio,
            right: (MediaQuery.of(context).size.width - 400) / 2.0,
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height / height_ratio -
                  60 * border_ratio,
              width: 400,
              child: Image.asset('images/About_app.png'),
            ),
          ),
          Positioned(
              bottom: 13 * border_ratio,
              right: (MediaQuery.of(context).size.width - 400) / 2.0 +
                  border_space -
                  18 * border_ratio,
              child: Container(
                color: Colors.transparent,
                child: TestButton(
                  scale_factor:
                  (MediaQuery.of(context).size.height / 1.1) / 812.0,
                ),
              )),
          Positioned(
              bottom: 13 * border_ratio,
              right: (MediaQuery.of(context).size.width - 400) / 2.0 +
                  border_space -
                  18 * border_ratio +
                  84 * border_ratio,
              child: Container(
                color: Colors.transparent,
                child: TestButton(
                  scale_factor:
                  (MediaQuery.of(context).size.height / 1.1) / 812.0,
                ),
              )),
          Positioned(
            top: 130 * border_ratio,
            left: (MediaQuery.of(context).size.width - 400) / 2.0 + border_space + 4 * border_ratio,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height/1.3,
              width: 400 - border_space * 2 - 8 * border_ratio,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                        'sed do eiusmod tempor incididunt ut labore et dolore '
                        'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                        'exercitation ullamco laboris nisi ut aliquip ex ea '
                        'commodo consequat. Duis aute irure dolor in '
                        'reprehenderit in voluptate velit esse cillum dolore eu '
                        'fugiat nulla pariatur. Excepteur sint occaecat cupidatat '
                        'non proident, sunt in culpa qui officia deserunt mollit '
                        'anim id est laborum.''Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                        'sed do eiusmod tempor incididunt ut labore et dolore '
                        'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                        'exercitation ullamco laboris nisi ut aliquip ex ea '
                        'commodo consequat. Duis aute irure dolor in '
                        'reprehenderit in voluptate velit esse cillum dolore eu '
                        'fugiat nulla pariatur. Excepteur sint occaecat cupidatat '
                        'non proident, sunt in culpa qui officia deserunt mollit '
                        'anim id est laborum.', style: triviaSmall1,)
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TestButton extends StatefulWidget {
  final scale_factor;

  TestButton({Key? key, this.scale_factor}) : super(key: key);

  @override
  State<TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
  var d = 0.0;
  var pd;

  @override
  void initState() {
    d = widget.scale_factor;
    pd = Image.asset(
      'assets/images/next_page_not_pressed.png',
      height: 38 * d,
      fit: BoxFit.contain,
    );
  }

  @override
  void didUpdateWidget(TestButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    d = widget.scale_factor;
    pd = Image.asset(
      'assets/images/next_page_not_pressed.png',
      height: 38 * d,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        var snackBar = SnackBar(
          content: Text('yay'),
        );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          pd = Image.asset(
            'assets/images/next_page_pressed.png',
            height: 38 * d,
          );
        });
      },
      onTapUp: (tap) {
        var snackBar = SnackBar(
          content: Text('not_yay'),
        );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          pd = Image.asset(
            'assets/images/next_page_not_pressed.png',
            height: 38 * d,
          );
        });
      },
      child: pd,
    );
  }
}