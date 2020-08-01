import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final Color bgColorLight = Colors.white;
//  static final Color textColorLight = Colors.deepOrange;
  static final Color primaryColorLight = Colors.deepOrange;
  static final Color secondaryColorLight = Colors.indigo;
  static final Color accentColorLight = Colors.indigoAccent;

  static final Color bgColorDark = Colors.black;
//  static final Color textColorDark = Colors.white;
  static final Color primaryColorDark = Colors.indigo;
  static final Color secondaryColorDark = Colors.deepOrange;
  static final Color accentColorDark = Colors.deepOrangeAccent;

  static final ThemeData lightTheme = ThemeData(
    accentColor: primaryColorLight,
    scaffoldBackgroundColor: bgColorLight,
    errorColor: accentColorDark,
    textTheme: TextTheme(
//      bodyText1: TextStyle(
//        color: textColorLight,
//      ),
    ),
    appBarTheme: AppBarTheme(
      color: primaryColorLight,
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColorLight,
      secondary: secondaryColorLight,
    ),
    bottomAppBarColor: primaryColorLight,

    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColorLight,
        secondary: secondaryColorLight,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    accentColor: primaryColorDark,
    scaffoldBackgroundColor: bgColorDark,
    errorColor: accentColorLight,
    textTheme: TextTheme(
//      bodyText1: TextStyle(
//        color: textColorDark,
//      ),
//      headline5: TextStyle(
//        color: textColorDark,
//      ),
//      bodyText2: TextStyle(
//        color: textColorDark,
//      ),
    ),
    appBarTheme: AppBarTheme(
      color: primaryColorDark,
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryColorDark,
      secondary: secondaryColorDark,
    ),
    bottomAppBarColor: primaryColorDark,
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.dark(
        primary: primaryColorDark,
        secondary: secondaryColorDark,
      ),
    ),
  );
}