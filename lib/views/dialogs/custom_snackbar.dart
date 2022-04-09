import 'package:flutter/material.dart';

class CustomSnackBar {
  static const double height = 20;
  static const double widthPercentage = 0.8;

  static void showSuccessSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          alignment: Alignment.center,
          height: height,
          width: MediaQuery.of(context).size.width*widthPercentage,
          child: Text(text)),
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    ));
  }

  static void showFailSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          alignment: Alignment.center,
          height: height,
          width: MediaQuery.of(context).size.width*widthPercentage,
          child: Text(text)),
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ));
  }
}

