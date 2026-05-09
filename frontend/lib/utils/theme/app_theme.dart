import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const Color primaryGreen = Color(0xFF1B5E3E); // Dark green from image
  static const Color primaryGreenLight = Color(0xFF4CAF50);

  // Neutral colors
  static const Color grayText = Color(0xFF9CA3AF);
  static const Color grayBorder = Color(0xFFE5E7EB);
  static const Color background = Color(0xFFFAF8F6);
  static const Color white = Color(0xFFFFFFFF);

  // Accent color (for claims)
  static const Color accentRed = Color(0xFFC66060);

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        onPrimary: white,
        secondary: primaryGreenLight,
        surface: white,
        onSurface: Colors.black87,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: white,
        indicatorColor: primaryGreen,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: primaryGreen,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            );
          }
          return const TextStyle(
            color: grayText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryGreen, size: 28);
          }
          return const IconThemeData(color: grayText, size: 24);
        }),
      ),
    );
  }

  // Dark Theme (optional)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryGreenLight,
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    );
  }
}
