import 'package:bhaktchintamani/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Constants {
  static String defaultColor = "defaultColor";

  static bottomBar(String Name, String Icon, int defaultColor) {
    return SalomonBottomBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: SvgPicture.asset(
          Icon,
          height: 22,
          width: 22,
          color: Color(0xffB4B4B4),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: SvgPicture.asset(
          "assets/images/language.svg",
          height: 22,
          width: 22,
          color: DefaultColor.dc(defaultColor),
        ),
      ),
      title: Text(
        Name,
        style: TextStyle(
          color: DefaultColor.dc(defaultColor),
          fontFamily: "Gujarati-Bold",
          fontSize: 15,
        ),
      ),
      selectedColor: DefaultColor.dc(defaultColor).withOpacity(0.4),
    );
  }
}
