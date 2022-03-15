import 'package:flutter/material.dart';
import 'package:trivia_app/views/pages/guidelines_page.dart';
import 'package:trivia_app/views/pages/landing_page.dart';
import 'package:trivia_app/views/pages/lobby_page.dart';
import 'package:trivia_app/views/pages/rules_page.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/pages/unknown_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.black12,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: LandingPage.routeName,
      routes: {
        LandingPage.routeName: (context) => LandingPage(),
        TeamFormationPage.routeName: (context) => TeamFormationPage(),
        LobbyPage.routeName: (context) => LobbyPage(),
        RulesPage.routeName: (context) => RulesPage(),
        GuidelinesPage.routeName: (context) => GuidelinesPage()
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
