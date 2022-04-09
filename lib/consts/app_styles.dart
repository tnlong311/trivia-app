import 'package:flutter/material.dart';
import 'dart:ui';

// This file includes all the style used in the app
// To import a new font:
// - Add the font file to fonts/
// - Edit the fonts in pubspec.yaml
// - Edit the fontFamily in TextStyle

// TODO:
// - decide the style for the text in the app (which font, how thick, color, etc.)


const triviaHeading1 = TextStyle(
    color: Colors.pinkAccent,
    fontWeight: FontWeight.w600,
    fontFamily: 'PixelFont',
    letterSpacing: 0.6,
    fontSize: 40,
    height: 2,
    decoration: TextDecoration.none);

const triviaSmall1 = TextStyle(
    color: Colors.pinkAccent,
    fontWeight: FontWeight.w200,
    fontFamily: 'PixelFont',
    letterSpacing: 0.6,
    fontSize: 13,
    height: 2,
    decoration: TextDecoration.none);
const triviaSmall2 = TextStyle(
    color: Colors.redAccent,
    fontWeight: FontWeight.w200,
    fontFamily: 'PixelFont',
    letterSpacing: 0.6,
    fontSize: 20,
    height: 2,
    decoration: TextDecoration.none);

const triviaHeading2 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontFamily: 'PixelFont',
    letterSpacing: 0.6,
    fontSize: 50,
    height: 2,
    shadows: <Shadow> [
      Shadow(
        offset: Offset(4.0, 4.0),
        blurRadius: 1.0,
        color: Color.fromARGB(255, 232,27,119),
      ),
      Shadow(
        offset: Offset(-4.0, -4.0),
        blurRadius: 1.0,
        color: Color.fromARGB(255, 67,230,244),
      ),
    ],
    decoration: TextDecoration.none,
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
