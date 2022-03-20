import 'package:flutter/material.dart';

const triviaHeading1 = TextStyle(
  color: Colors.pinkAccent,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.6,
  fontSize: 40,
  height: 2,
  decoration: TextDecoration.none
);

const triviaHeading2 = TextStyle(
  color: Colors.pinkAccent,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
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