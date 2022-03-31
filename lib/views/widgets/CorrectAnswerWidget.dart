import 'package:flutter/cupertino.dart';

import '../../consts/app_styles.dart';

class CorrectAnswerWidget extends StatelessWidget {
  const CorrectAnswerWidget(
      {Key? key, required this.header, required this.content})
      : super(key: key);

  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Text(
                header,
                style: triviaHeading2,
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: triviaHeading1,
              ),
            ),
          ]),
    );
  }
}
