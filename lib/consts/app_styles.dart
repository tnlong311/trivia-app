import 'package:flutter/material.dart';
// This file includes all the style used in the app
// To import a new font:
// - Add the font file to fonts/
// - Edit the fonts in pubspec.yaml
// - Edit the fontFamily in TextStyle

// TODO:
// - decide the style for the text in the app (which font, how thick, color, etc.)

const triviaHeading1 = TextStyle(
  color: Colors.pinkAccent,
  fontWeight: FontWeight.w800,
  fontFamily: 'Garamond',
  letterSpacing: 0.6,
  fontSize: 40,
  height: 2,
  decoration: TextDecoration.none
);

const triviaHeading2 = TextStyle(
  color: Colors.pinkAccent,
  fontWeight: FontWeight.w800,
  fontFamily: 'Garamond',
  letterSpacing: 0.6,
  fontSize: 30,
  height: 2,
  decoration: TextDecoration.none
);

const triviaGreen = LinearGradient(
colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
begin: Alignment.centerLeft,
end: Alignment.centerRight,
);

const triviaRed = LinearGradient(
  colors: [Color(0xDFa70000), Color(0xDFfe2424)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);