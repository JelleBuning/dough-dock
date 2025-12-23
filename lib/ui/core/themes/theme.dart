import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(toolbarHeight: 60, elevation: 0),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 187, 0),
      brightness: Brightness.dark,
      error: const Color.fromARGB(255, 255, 78, 78),
    ),
    cardTheme: CardThemeData(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(toolbarHeight: 60, elevation: 0),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 255, 187, 0),
      brightness: Brightness.light,
      error: const Color.fromARGB(255, 255, 78, 78),
    ),
    cardTheme: CardThemeData(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ),
  );
}
