import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox(
      {Key? key, this.title, required this.width, required this.height})
      : super(key: key);

  final String? title;
  final double width;
  final double height;

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
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Time left',
              style: themeData.textTheme.headline6,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '100',
                style: themeData.textTheme.headline3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
