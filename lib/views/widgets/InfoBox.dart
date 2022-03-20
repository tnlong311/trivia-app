import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox(
      {Key? key, required this.title, required this.width, required this.height, required this.content})
      : super(key: key);

  final String title;
  final double width;
  final double height;
  final String content;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black38,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 4),
          )
        ],
      ),
      child: Column(
        children: [
          (title != "") ?
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: themeData.textTheme.subtitle1,
            ),
          ) : SizedBox.shrink(),
          Expanded(
            child: Center(
              child: Text(
                content,
                style: themeData.textTheme.headline3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
