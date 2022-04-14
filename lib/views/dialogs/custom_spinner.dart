import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner {
  static Widget PouringHourGlass() {
    return const SpinKitPouringHourGlass(
      color: Colors.white,
      size: 100.0,
    );
  }

  static Widget FadingCube() {
    return const SpinKitFadingCube(
      color: Colors.white,
      size: 60.0,
    );
  }
}
