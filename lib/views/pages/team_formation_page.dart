import 'package:flutter/material.dart';
import 'package:trivia_app/services/auth_service.dart';
import 'package:trivia_app/services/user_service.dart';
import 'package:trivia_app/views/widgets/TextFieldWithButton.dart';

import '../../consts/app_styles.dart';
import 'lobby_page.dart';

class TeamFormationPage extends StatefulWidget {
  static const routeName = "/team-formation";

  const TeamFormationPage({Key? key}) : super(key: key);

  @override
  State<TeamFormationPage> createState() => _TeamFormationPageState();
}

class _TeamFormationPageState extends State<TeamFormationPage> {
  var _name = 'STEMer';

  inputValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 6) {
      return 'Must be at least 6 chars';
    } else if (value.length > 15) {
      return 'Must be at most 15 chars';
    }

    return null;
  }

  inputUpdator(value) async {
    var pin = await RtdbUserService.getCurrentUserPin();

    if (pin.toString() == '') {
      return false;
    } else {
      setState(() {
        _name = value;
      });
      await RtdbUserService.setName(pin.toString(), value);
      print('Set group name $value with pin $pin');
      return true;
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
                          failMsg: 'An error has occured',
                          successMsg:
                              'Welcome, $_name',
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
