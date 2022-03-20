import 'dart:ui';

import 'package:flutter/material.dart';

import '../../consts/app_styles.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.progress}) : super(key: key);
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: LayoutBuilder(
          builder: (context, constraints) => Container(
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: (progress > 0.5) ? triviaGreen : triviaRed,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
    );
  }
}
