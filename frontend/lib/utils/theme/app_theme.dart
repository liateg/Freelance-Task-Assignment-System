import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryGreen = Color(0xFF1B5E3E); // Dark green from image
  static const Color primaryGreenLight = Color(0xFF4CAF50);

  // Neutral colors
  static const Color grayText = Color(0xFF9CA3AF);
  static const Color grayBorder = Color(0xFFE5E7EB);
  static const Color background = Color(0xFFFAF8F6);
  static const Color white = Color(0xFFFFFFFF);

  // Accent color (for claims)
  static const Color accentRed = Color(0xFFC66060);

  // Status colors
  static const Color statusPendingLight = Color(0xFFC8E6C9); // Light green
  static const Color statusApprovedLight = Color(0xFF81C784); // Green
  static const Color statusRejectedLight =
      Color(0xFFD7CCC8); // Light brownish-gray

  // Detail screen colors
  static const Color detailScreenBackground =
      Color(0xFFF6F6F6); // Light gray background
  static const Color descriptionText = Color(0xFF5F6B66); // Dark grayish-green
  static const Color feedbackCardBackground =
      Color(0xFF8FA282); // Muted sage green
  static const Color feedbackText = Color(0xFF6E746F); // Dark gray
  // Admin card colors
  static const Color adminCardBackground = Color(0xFFF3F0EA);
  static const Color adminActionGreen = Color(0xFF0C5C3B);
  static const Color adminLocationGreen = Color(0xFF0C5C3B);
  static const Color adminDashboardSurface = Color(0xFFF0EEE9);
  static const Color adminDashboardDeepGreen = Color(0xFF114B34);
  static const Color adminDashboardChip = Color(0xFFFCE8D7);
  static const Color adminDashboardChipText = Color(0xFFBC6A1F);

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
