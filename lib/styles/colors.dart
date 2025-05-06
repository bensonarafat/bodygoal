import 'package:bodygoal/logic/common/color_utils.dart';
import 'package:flutter/material.dart';

class AppColors {
  final Color accent1 = const Color(0xffc6002f);
  final Color accent2 = const Color(0xFFBEABA1);
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color caption = const Color(0xFF7D7873);
  final Color body = const Color(0xFF514F4D);
  final Color greyStrong = const Color(0xFF272625);
  final Color greyMedium = const Color(0xFF9D9995);
  final Color white = Colors.white;
  final Color shimmer = const Color(0xFF1A1A1A);
  final Color background = const Color(0xff1c1c1c);
  final Color backgroundLight = const Color(0xff333333);
  final List<Color> linearGrident = const [
    Color(0xFF222222),
    Color(0xFF333333),
    Color(0xFF222222),
  ];
  final Color clipColor = const Color(0xff201e20);

  final Color black = const Color(0xff000000);

  final Color transparent = Colors.transparent;

  final bool isDark = false;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}
