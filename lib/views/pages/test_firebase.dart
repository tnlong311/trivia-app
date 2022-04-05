import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:trivia_app/models/question.dart';
import 'package:trivia_app/views/widgets/TextFieldSingle.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/InfoBox.dart';

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
    // DatabaseReference ref = FirebaseDatabase.instanceFor(
    //         app: Firebase.app(),
    //         databaseURL: 'https://trivia-app-37d1b-default-rtdb.firebaseio.com')
    //     .ref();
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

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

    answerOnSubmit() async {
      print('kicked');
      DatabaseReference questionsRef = ref.child('/game bank/2022/questions');

      // final keyname = await questionsRef.push().key;
      //
      // final testData = <String, dynamic>{
      //   'id': keyname,
      //   'type': 'string',
      //   'correct': 'B',
      //   'full correct': 'B. Long rat ngau',
      //   'addition info': 'This question is very interesting!!',
      //   'clock': DateTime.now().millisecondsSinceEpoch
      // };

      // await childs.child(keyname!).set(testData)
      // .then((_) => print('done'))
      // .catchError((error) => print(error));
      await questionsRef.get().then((DataSnapshot snapshot) {
        print(snapshot.value);
        // final data = Map<String, dynamic>.from(snapshot. as Map);
        for (var q in (snapshot.value as List)) {
          print(q);
          // if (q != null) {
          //   Question question = Question.fromRTDB(q);
          //   // print('${question.id} ${question.additionInfo}  ${question.correct}');
          //   // print(question.clock);
          // }
        }
        // print(snapshot.value as Map);
      });

      if (_formKey.currentState!.validate()) {
        // update state to Controller
        _formKey.currentState!.save();
        // _questionController.resetQuestionState();
      }
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
