import 'package:flutter/material.dart';
final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.orange,
  //hintColor: Colors.orange,
  splashColor: Colors.orange,
  highlightColor: Colors.orange,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

// App border radius styles
class AppBorderRadius {
  static const BorderRadius small = BorderRadius.all(Radius.circular(10.0));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(15.0));
  static const BorderRadius large = BorderRadius.all(Radius.circular(20.0));

  static BorderRadius circular() {
    return BorderRadius.circular(100.0);
  }
}