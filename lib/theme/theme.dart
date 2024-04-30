import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
    brightness: Brightness.light,
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    cardTheme: CardTheme(color: Colors.white24),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black,
    ),
    colorScheme: ColorScheme.light(
      secondary: Colors.blue.shade400,
      primaryContainer: Colors.grey.shade400,
      primary: Colors.white,
    ));
ThemeData darkTheme = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
    brightness: Brightness.dark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(color: Colors.white10),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black,
        contentTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
    colorScheme: ColorScheme.dark(
      primaryContainer: Colors.grey.shade800,
      secondary: Colors.blue.shade800,
      primary: Colors.black,
    ));
