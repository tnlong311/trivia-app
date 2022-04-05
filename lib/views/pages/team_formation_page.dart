import 'package:flutter/material.dart';

import '../../consts/app_styles.dart';
import '../../services/authService.dart';
import '../widgets/TextFieldWithButton.dart';
import 'lobby_page.dart';

class TeamFormationPage extends StatefulWidget {
  static const routeName = "/team-formation";

  const TeamFormationPage({Key? key}) : super(key: key);

  @override
  State<TeamFormationPage> createState() => _TeamFormationPageState();
}

class _TeamFormationPageState extends State<TeamFormationPage> {
  bool _isLoggedIn = false;

  validateSignIn(value) async {
    var pin = await AuthService.signIn(value);

    if (pin != '') {
      print(pin);
      return true;
    } else {
      return false;
    }
  }

  inputValidator(value) {
    print(_isLoggedIn);
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!_isLoggedIn) {
      return 'Wrong game code';
    }

    return null;
  }

  inputUpdator(value) async {
    if (value != '' && value != null) {
      await validateSignIn(value).then((status) {
        if (status) {
          _isLoggedIn = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/BackGround.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(style: triviaHeading1, children: [
                      TextSpan(text: "How can we\ncall your group?"),
                    ]),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: isKeyboard
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: TextFieldWithButton(

                          validator: inputValidator,
                          updator: inputUpdator,
                          routeName: LobbyPage.routeName,
                          isKeyboard: isKeyboard),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ]);
  }
}
