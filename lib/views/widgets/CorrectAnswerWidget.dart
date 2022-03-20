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
    return Column(children: [
      Text(header, style: triviaHeading1),
      Text(
        content,
      ),
    ]);
  }
}
