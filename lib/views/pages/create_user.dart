import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUserPage extends StatefulWidget {
  static const routeName = "/create-user";

  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    FirebaseAuth auth = FirebaseAuth.instance;

    answerOnSubmit() async {
      print('kicked');
      // CustomUser.createCustomUser();
      // CustomUser.getPinList();
      await auth.signInWithEmailAndPassword(email: '31120@trivia.com', password: 'triviaiscool');
      print('done');
    }

    return Scaffold(
      body: SafeArea(
          child: GetBuilder<GameController>(
              init: GameController(),
              builder: (controller) {
                return Column(
                  children: [
                    const Expanded(
                      flex: 2,
                        child: Text(
                      "Create random user",
                      style: triviaHeading2,
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: answerOnSubmit,
                            child: Text(
                              "Create user",
                              style: themeData.textTheme.headline5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
