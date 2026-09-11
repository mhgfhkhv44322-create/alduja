import 'package:flutter/material.dart';
import 'screens/majalis_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );

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
