import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trivia_app/controllers/score_controller.dart';
import 'package:trivia_app/views/pages/guidelines_page.dart';
import 'package:trivia_app/views/pages/landing_page.dart';
import 'package:trivia_app/views/pages/lobby_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';
import 'package:trivia_app/views/pages/rules_page.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/pages/test_firebase.dart';
import 'package:trivia_app/views/pages/unknown_page.dart';

import 'controllers/game_controller.dart';
import 'controllers/score_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // name: "Trivia App",
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => print('initialized firebase'));

  runApp(const MyApp());

  // testt 2
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
        // initialRoute: QuestionTitlePage.routeName,
        // initialRoute: TestFirebasePage.routeName,
        routes: {
          LandingPage.routeName: (context) => const LandingPage(),
          TeamFormationPage.routeName: (context) => const TeamFormationPage(),
          LobbyPage.routeName: (context) => LobbyPage(),
          RulesPage.routeName: (context) => const RulesPage(),
          GuidelinesPage.routeName: (context) => const GuidelinesPage(),
          QuestionTitlePage.routeName: (context) => const QuestionTitlePage(),
          QuestionPollPage.routeName: (context) => const QuestionPollPage(),
          AnswerRevealPage.routeName: (context) => const AnswerRevealPage(),
          AnswerInfoPage.routeName: (context) => const AnswerInfoPage(),
          TestFirebasePage.routeName: (context) => const TestFirebasePage(),
        },
        // in case passing data to the next page
        // onGenerateRoute: (RouteSettings settings) {
        //   https://github.com/iampawan/Flutter-Routes/blob/master/lib/main.dart
        // },
        onGenerateInitialRoutes: (settings) {
          print('hello');
          return
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => const UnknownPage());
        });
  }
}
