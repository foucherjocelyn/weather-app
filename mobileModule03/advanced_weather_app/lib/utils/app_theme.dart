import 'package:flutter/material.dart';

class AppTheme {
  // Main colors
  static const Color primaryColor = Color(0xFF1A5B9C);
  static const Color accentColor = Color(0xFFFF9E44);
  static const Color cardColor = Color(0xBBFFFFFF); // Semi-transparent white
  static const Color textColor = Color(0xFF0A2847);
  static const Color lightTextColor = Color(0xFFF0F5FA);
  
  // Create the theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: lightTextColor),
        titleTextStyle: TextStyle(
          color: lightTextColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Tab bar theme
      tabBarTheme: const TabBarTheme(
        labelColor: lightTextColor,
        unselectedLabelColor: Color(0xAAF0F5FA),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: accentColor, width: 3),
          ),
        ),
      ),
      // Card theme
      cardTheme: const CardTheme(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      // Text theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor, fontSize: 16),
        bodyMedium: TextStyle(color: textColor, fontSize: 14),
        titleLarge: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}