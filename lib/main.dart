import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/guidelines_page.dart';
import 'package:trivia_app/views/pages/landing_page.dart';
import 'package:trivia_app/views/pages/lobby_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';
import 'package:trivia_app/views/pages/question_template/answer_reveal_page.dart';
import 'package:trivia_app/views/pages/question_template/question_poll_page.dart';
import 'package:trivia_app/views/pages/question_template/question_title_page.dart';
import 'package:trivia_app/views/pages/rules_page.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/pages/unknown_page.dart';

void main() {
  runApp(const MyApp());
  // test2
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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyanAccent),
      ),
      initialRoute: LandingPage.routeName,
      // initialRoute: QuestionTitlePage.routeName,
      routes: {
        LandingPage.routeName: (context) => LandingPage(),
        TeamFormationPage.routeName: (context) => TeamFormationPage(),
        LobbyPage.routeName: (context) => LobbyPage(),
        RulesPage.routeName: (context) => RulesPage(),
        GuidelinesPage.routeName: (context) => GuidelinesPage(),
        QuestionTitlePage.routeName: (context) => QuestionTitlePage(),
        QuestionPollPage.routeName: (context) => QuestionPollPage(),
        AnswerRevealPage.routeName: (context) => AnswerRevealPage(),
        AnswerInfoPage.routeName: (context) => AnswerInfoPage(),
      },
        // in case passing data to the next page
      // onGenerateRoute: (RouteSettings settings) {
      //   https://github.com/iampawan/Flutter-Routes/blob/master/lib/main.dart
      // },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const UnknownPage());
      }
    );
  }
}
