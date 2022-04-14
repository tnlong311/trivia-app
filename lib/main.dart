import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/controllers/game_controller.dart';
import 'package:trivia_app/controllers/score_controller.dart';
import 'package:trivia_app/services/auth_service.dart';
import 'package:trivia_app/services/user_service.dart';
import 'package:trivia_app/utils/custom_routing.dart';
import 'package:trivia_app/views/pages/end_page.dart';
// import 'package:trivia_app/views/pages/admin/create_user.dart';
// import 'package:trivia_app/views/pages/end_page.dart';
// import 'package:trivia_app/views/pages/guidelines_page.dart';
import 'package:trivia_app/views/pages/landing_page.dart';
import 'package:trivia_app/views/pages/lobby_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';
import 'package:trivia_app/views/pages/rules_page.dart';
// import 'package:trivia_app/views/pages/lobby_page.dart';
// import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';
// import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
// import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
// import 'package:trivia_app/views/pages/question_template/question_title_page.dart';
// import 'package:trivia_app/views/pages/rules_page.dart';
// import 'package:trivia_app/views/pages/team_formation_page.dart';
// import 'package:trivia_app/views/pages/admin/test_firebase.dart';
import 'package:trivia_app/views/pages/unknown_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // name: "Trivia App",
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => print('initialized firebase'));

  // available for web only
  // await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
  // delete this after done
  // await AuthService.signOut();
  GameController _gameController = Get.put(GameController());
  ScoreController _scoreController = Get.put(ScoreController());

  final statusRef =
      FirebaseDatabase.instance.ref().child('/gameplay/2022/game status/');

  statusRef.onChildChanged.listen((event) async {
    var questionNum = int.tryParse(event.snapshot.value.toString()) ?? 0;
    var pin = AuthService.getPin();
    var isNamed = await RtdbUserService.isNamed(pin);
    GameController _gameController = Get.put(GameController());
    ScoreController _scoreController = Get.put(ScoreController());

    if(_gameController.questionsLength == 0) {
      await _gameController.fetchQuestions();
    }
    if(_scoreController.questionsLength == 0) {
      await _scoreController.fetchAnswers();
    }

    if (AuthService.isSignedIn() && isNamed && questionNum > -1) {
      if (event.snapshot.key == 'current') {
        print('proceed to question $questionNum');

        _gameController.setIndexFromQuestionNum(questionNum);
        await _scoreController.fetchTotalScore();

        _gameController.gotoQuestionTitle();
      } else if (event.snapshot.key == 'reveal') {
        print('proceed to answer reveal on question $questionNum');

        _gameController.setIndexFromQuestionNum(questionNum);
        await _scoreController.fetchTotalScore();
        await _scoreController.fetchChange();

        _gameController.gotoAnswerReveal();
      }
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Trivia App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          // primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.cyanAccent),
        ),

        initialRoute: LandingPage.routeName,
        // initialRoute: RulesPage.routeName,
        // initialRoute: TestFirebasePage.routeName,
        // initialRoute: CreateUserPage.routeName,
        onGenerateRoute: CustomRouter.generateRoute,
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => const UnknownPage());
        });
  }
}
