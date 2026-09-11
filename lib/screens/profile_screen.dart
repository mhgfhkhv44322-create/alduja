import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? profile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() => loading = false);
      }
      return;
    }

    try {
      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (!mounted) return;

      setState(() {
        profile = data;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final username =
        profile?['username']?.toString() ??
            'مستخدم الدجى';

    final displayName =
        profile?['display_name']?.toString() ??
            username;

    final bio =
        profile?['bio']?.toString() ??
            'لا توجد نبذة بعد.';

    final title =
        profile?['title']?.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('أنا'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: loadProfile,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const CircleAvatar(
                    radius: 45,
                    child: Icon(
                      Icons.person_outline,
                      size: 45,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text('@$username'),
                  ),
                  if (title != null &&
                      title.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Center(
                      child: Chip(
                        label: Text(title),
                      ),
                    ),
                  ],
                  const SizedBox(height: 22),
                  Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),
                      child: Text(
                        bio,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.emoji_events_outlined,
                      ),
                      title: Text('الإنجازات'),
                      subtitle: Text(
                        'إنجازاتك وألقابك',
                      ),
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.link),
                      title: Text(
                        'رابط رسائلي المجهولة',
                      ),
                      subtitle: Text(
                        'استقبال رسائل بدون كشف هوية المرسل',
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
