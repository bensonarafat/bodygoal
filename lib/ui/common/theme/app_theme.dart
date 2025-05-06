import 'package:bodygoal/main.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        fontFamily: $styles.text.body.fontFamily,
        useMaterial3: true,
      );

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        fontFamily: $styles.text.body.fontFamily,
        useMaterial3: true,
      );
}
