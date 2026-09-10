import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AldujaApp());
}

class AldujaApp extends StatelessWidget {
  const AldujaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الدجى',
      theme: AldujaTheme.dark(),
      home: const LoginScreen(),
    );
  }
}
