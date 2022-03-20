import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/question_template/answer_info_page.dart';
import 'package:trivia_app/views/widgets/InfoBox.dart';

import '../../widgets/CorrectAnswerWidget.dart';

class AnswerRevealPage extends StatelessWidget {
  static const routeName = "/answer-reveal";

  const AnswerRevealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: const [
          Expanded(
            flex: 1,
            child: Center(
                child: InfoBox(
                    title: "", width: 200, height: 120, content: "+200")),
          ),
          Expanded(
            flex: 1,
            child: CorrectAnswerWidget(header: "The correct answer izz", content: "A. Hello"),
          ),
          Expanded(
            flex: 1,
            child: CorrectAnswerWidget(header: "Your current point", content: "1000"),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AnswerInfoPage.routeName);
        },
      ),
    );
  }
}
