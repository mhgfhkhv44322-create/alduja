import 'package:flutter/material.dart';

class AldujaTheme {
  static ThemeData dark() {
      return ThemeData(
            brightness: Brightness.dark,
                  scaffoldBackgroundColor: const Color(0xFF080B12),
                        colorScheme: const ColorScheme.dark(
                                primary: Color(0xFFD4AF5A),
                                        secondary: Color(0xFFD4AF5A),
                                                surface: Color(0xFF10141D),
                                                      ),
                                                            appBarTheme: const AppBarTheme(
                                                                    backgroundColor: Color(0xFF080B12),
                                                                            foregroundColor: Color(0xFFD4AF5A),
                                                                                    elevation: 0,
                                                                                          ),
                                                                                                textTheme: const TextTheme(
                                                                                                        bodyLarge: TextStyle(
                                                                                                                  color: Colors.white,
                                                                                                                          ),
                                                                                                                                  bodyMedium: TextStyle(
                                                                                                                                            color: Color(0xFFB9BDC7),
                                                                                                                                                    ),
                                                                                                                                                            titleLarge: TextStyle(
                                                                                                                                                                      color: Color(0xFFD4AF5A),
                                                                                                                                                                                fontWeight: FontWeight.bold,
                                                                                                                                                                                        ),
                                                                                                                                                                                              ),
                                                                                                                                                                                                  );
                                                                                                                                                                                                    }
                                                                                                                                                                                                    }