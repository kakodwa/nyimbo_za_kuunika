import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors from Zambezi Evangelical Church Logo
  static const Color zecBlue = Color(0xFF2A5298);
  static const Color zecDarkBlue = Color(0xFF1B365D);
  static const Color zecGold = Color(0xFFF5B041);
  static const Color zecLightGreen = Color(0xFFD4E615);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: zecBlue,
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    colorScheme: const ColorScheme.light(
      primary: zecBlue,
      secondary: zecGold,
      tertiary: zecLightGreen,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: zecBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: zecBlue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: zecBlue,
      secondary: zecGold,
      tertiary: zecLightGreen,
      surface: Color(0xFF1E1E1E),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B365D),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}