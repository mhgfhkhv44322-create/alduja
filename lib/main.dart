import 'package:flutter/material.dart';

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
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'الدجى',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
