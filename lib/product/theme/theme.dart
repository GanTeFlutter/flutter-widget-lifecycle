import 'package:flutter/material.dart';

final class AppDarkTheme {
  ThemeData get themeData => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.amber,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.grey,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(displaySmall: TextStyle(color: Colors.white)),
  );
}

final class AppLightTheme {
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(displaySmall: TextStyle(color: Colors.black)),
  );
}

final class AppTheme {
  final AppLightTheme lightTheme = AppLightTheme();
  final AppDarkTheme darkTheme = AppDarkTheme();
}
