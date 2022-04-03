import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/controllers/question_controller.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';

import '../widgets/InfoBox.dart';

class TestFirebasePage extends StatefulWidget {
  static const routeName = "/test";

  const TestFirebasePage({Key? key}) : super(key: key);

  @override
  State<TestFirebasePage> createState() => _TestFirebasePageState();
}

class _TestFirebasePageState extends State<TestFirebasePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    QuestionController _questionController = Get.put(QuestionController());
    // DatabaseReference ref = FirebaseDatabase.instance.ref();
    DatabaseReference ref = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL: 'https://trivia-app-37d1b-default-rtdb.firebaseio.com')
        .ref();

    answerValidator(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    betValidator(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a number';
      }
      return null;
    }

    answerUpdator(value) {
      _questionController.setUserAnswer(value);
      // print(_questionController.userAnswer);
    }

    betUpdator(value) {
      _questionController.setBet(value);
      // print(_questionController.bet);
    }

    answerOnSubmit() async {
      print('kicked');
      DatabaseReference childs = ref.child('test');

      print(await childs.child('hello').get());

      final keyname = await childs.push().key;

      final testData = <String, dynamic>{
        'id': keyname,
        'type': 'string',
        'correct': 'B',
        'full correct': 'B. Long rat ngau',
        'addition info': 'This question is very interesting!!',
        'clock': DateTime.now().millisecondsSinceEpoch
      };

      // await childs.get().asStream().forEach((element) {
      //   print(element.value);
      //   print('\n');
      // });

      // print(await childs.child('hello').get());

      await childs.child(keyname!).set(testData)
      .then((_) => print('done'))
      .catchError((error) => print(error));

      if (_formKey.currentState!.validate()) {
        // update state to Controller
        _formKey.currentState!.save();
        _questionController.checkAnswer();
        // _questionController.resetQuestionState();
      }
    }

    return Scaffold(
      body: SafeArea(
          child: GetBuilder<QuestionController>(
              init: QuestionController(),
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
                      flex: 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InfoBox(
                              title: "Current Point",
                              width: 150,
                              height: 120,
                              content: '${controller.currentPoint}',
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 2,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 30),
                            TextFieldSingle(
                                width: 250,
                                title: "Answer",
                                description: "Enter your answer...",
                                validator: answerValidator,
                                updator: answerUpdator),
                            TextFieldSingle(
                                width: 250,
                                title: "Bet",
                                description: "Enter your bet...",
                                validator: betValidator,
                                updator: betUpdator),
                          ],
                        ),
                      ),
                    ),
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
