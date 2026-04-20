import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF141416);
  static const Color surface = Color(0xFF1C1C1E);
  static const Color surfaceHighlight = Color(0xFF28282A);

  // Text
  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFFA0A0A5);

  // Accents / Indicators
  static const Color primary = Color(0xFF32D74B); // Bright Green
  static const Color secondary = Color(0xFF0A84FF); // Blue
  static const Color warning = Color(0xFFFF9F0A); // Orange / Warning
  static const Color danger = Color(0xFFFF453A); // Red / High Risk
  static const Color moisture = Color(0xFF64D2FF); // Light Blue

  static const LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0xFF222226),
      Color(0xFF1A1A1C),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
