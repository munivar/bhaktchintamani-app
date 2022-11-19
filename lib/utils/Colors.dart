import 'package:flutter/material.dart';

class DefaultColor {
  static Color primaryColor = const Color(0xff9F0A1E);
  static Color secondColor = const Color(0xff9D5257);
  static Color thirdColor = const Color(0xff1E251E);
  static Color fourhColor = const Color(0xff310D0D);
  static Color fifthColor = const Color(0xff7D7D7D);
  static Color sixthColor = const Color(0xff474747);
  static dc(int value) {
    if (value == 1) {
      return primaryColor;
    } else if (value == 2) {
      return secondColor;
    } else if (value == 3) {
      return thirdColor;
    } else if (value == 4) {
      return fourhColor;
    } else if (value == 5) {
      return fifthColor;
    } else if (value == 6) {
      return sixthColor;
    }
  }
}
