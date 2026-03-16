import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF4F6FA),
    primaryColor: const Color(0xFF22C55E),
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF22C55E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF22C55E),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF22C55E),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    primaryColor: const Color(0xFF22C55E),
    cardColor: const Color(0xFF1E293B),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF020617),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF22C55E),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E293B),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF22C55E),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );
}