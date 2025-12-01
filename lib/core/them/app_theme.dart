import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2563EB),
      onPrimary: Colors.white,
      secondary: Color(0xff10B981),
      onSecondary: Colors.white,
      error: Color(0xffEF4444),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xff1F2937),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff2563EB),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xff1F2937)),
      bodyMedium: TextStyle(color: Color(0xff1F2937)),
      bodySmall: TextStyle(color: Color(0xff6B7280)),
      titleLarge: TextStyle(
        color: Color(0xff111827),
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xff2563EB), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffEF4444)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff2563EB),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
  );
}
