import 'package:flutter/material.dart';

class AppColors {
  // Brand / Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF564FD8);
  static const Color primaryLight = Color(0xFF8580FF);

  static const Color secondary = Color(0xFF35D0BA);
  static const Color accent = Color(0xFFFF6B6B);

  // ===== Light Mode Palette =====
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF212529);
  static const Color lightTextSecondary = Color(0xFF6C757D);
  static const Color lightTextLight = Color(0xFFFFFFFF);
  static const Color lightButtonText = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFDEE2E6);

  // Shadows for light mode
  static const Color lightShadow = Color(0x33000000); // semi-transparent black

  // ===== Dark Mode Palette =====
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFEAEAEA);
  static const Color darkTextSecondary = Color(0xFF9E9E9E);
  static const Color darkTextLight = Color(0xFFFFFFFF);
  static const Color darkButtonText = Color(0xFF121212);
  static const Color darkBorder = Color(0xFF2C2C2C);

  // Shadows for dark mode
  static const Color darkShadow = Color(0x3300FFFF); // cyan glow-like

  // Feedback Colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);

  // Helper methods for theme aware usage
  static Color textPrimary(bool isDark) => isDark ? darkTextPrimary : lightTextPrimary;
  static Color textSecondary(bool isDark) => isDark ? darkTextSecondary : lightTextSecondary;
  static Color card(bool isDark) => isDark ? darkCard : lightCard;
  static Color background(bool isDark) => isDark ? darkBackground : lightBackground;
  static Color buttonText(bool isDark) => isDark ? darkButtonText : lightButtonText;
  static Color shadow(bool isDark) => isDark ? darkShadow : lightShadow;
  static Color border(bool isDark) => isDark ? darkBorder : lightBorder;
}
