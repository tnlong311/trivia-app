import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../views/pages/admin/create_user.dart';
import '../views/pages/admin/test_firebase.dart';
import '../views/pages/end_page.dart';
import '../views/pages/guidelines_page.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/lobby_page.dart';
import '../views/pages/question_template/answer_reveal_page.dart';
import '../views/pages/question_template/question_poll_page.dart';
import '../views/pages/question_template/question_title_page.dart';
import '../views/pages/rules_page.dart';
import '../views/pages/team_formation_page.dart';

class CustomRouter {
  // getx page transition
  static Future<T?> customGetTo<T>(dynamic page, {dynamic arguments}) async {
    return await Get.off<T>(
      page,
      arguments: arguments,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 400),
    );
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // if (!AuthService.isSignedIn()) {
    //   return MaterialPageRoute(builder: (_) => const LandingPage());
    // }

    switch (settings.name) {
      case LandingPage.routeName:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case TeamFormationPage.routeName:
        return MaterialPageRoute(builder: (_) => const TeamFormationPage());
      case LobbyPage.routeName:
        return MaterialPageRoute(builder: (_) => LobbyPage());
      case RulesPage.routeName:
        return MaterialPageRoute(builder: (_) => const RulesPage());
      case GuidelinesPage.routeName:
        return MaterialPageRoute(builder: (_) => const GuidelinesPage());
      case QuestionTitlePage.routeName:
        return MaterialPageRoute(builder: (_) => const QuestionTitlePage());
      case QuestionPollPage.routeName:
        return MaterialPageRoute(builder: (_) => const QuestionPollPage());
      case AnswerRevealPage.routeName:
        return MaterialPageRoute(builder: (_) => const AnswerRevealPage());
      case CreateUserPage.routeName:
        return MaterialPageRoute(builder: (_) => const CreateUserPage());
      case EndPage.routeName:
        return MaterialPageRoute(builder: (_) => const EndPage());
      default:
        return null;
    }
  }
}

// routes: {
//   LandingPage.routeName: (context) => const LandingPage(),
//   TeamFormationPage.routeName: (context) => const TeamFormationPage(),
//   LobbyPage.routeName: (context) => LobbyPage(),
//   RulesPage.routeName: (context) => const RulesPage(),
//   GuidelinesPage.routeName: (context) => const GuidelinesPage(),
//   QuestionTitlePage.routeName: (context) => const QuestionTitlePage(),
//   QuestionPollPage.routeName: (context) => const QuestionPollPage(),
//   AnswerRevealPage.routeName: (context) => const AnswerRevealPage(),
//   AnswerInfoPage.routeName: (context) => const AnswerInfoPage(),
//   TestFirebasePage.routeName: (context) => const TestFirebasePage(),
//   CreateUserPage.routeName: (context) => const CreateUserPage(),
//   EndPage.routeName: (context) => const EndPage(),
// },
