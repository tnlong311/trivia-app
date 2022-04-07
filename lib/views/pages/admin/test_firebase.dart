import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:trivia_app/models/question.dart';
import 'package:trivia_app/services/auth_service.dart';
import 'package:trivia_app/services/game_service.dart';
import 'package:trivia_app/services/user_service.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/InfoBox.dart';

class TestFirebasePage extends StatefulWidget {
  static const routeName = "/test";

  const TestFirebasePage({Key? key}) : super(key: key);

  @override
  State<TestFirebasePage> createState() => _TestFirebasePageState();
}

class _TestFirebasePageState extends State<TestFirebasePage> {
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   print("state intiated");
  // }
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    GameController _questionController = Get.put(GameController());
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    FirebaseAuth auth = FirebaseAuth.instance;

    answerOnSubmit() async {
      print('kicked');
      DatabaseReference gameRef = ref.child('/game play/2022');
      RtdbGameService.getCurrentQuestion();

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
                        child: Text(
                      "Test firebase",
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
                              "Submit",
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
