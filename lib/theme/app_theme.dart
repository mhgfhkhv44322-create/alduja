import 'package:flutter/material.dart';

class AldujaColors {
  static const background = Color(0xFF080A0F);
  static const surface = Color(0xFF11141B);
  static const gold = Color(0xFFD6B36A);
  static const textPrimary = Color(0xFFF2EEE5);
  static const textSecondary = Color(0xFFA9A49A);
}

class AldujaTheme {
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AldujaColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AldujaColors.gold,
        surface: AldujaColors.surface,
      ),
      fontFamily: 'sans',
    );
  }
}
