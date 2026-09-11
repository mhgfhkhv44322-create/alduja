import 'package:flutter/material.dart';

import 'blocked_users_screen.dart';
import 'my_reports_screen.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService settingsService = SettingsService();

  bool anonymousMessages = true;
  bool showTitle = true;
  bool notifications = true;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final data = await settingsService.getSettings();

      if (!mounted) return;

      if (data != null) {
        anonymousMessages = data['anonymous_messages'] ?? true;
        showTitle = data['show_title'] ?? true;
        notifications = data['notifications'] ?? true;
      }
    } catch (_) {}

    if (mounted) {
      setState(() => loading = false);
    }
  }

  Future<void> save() async {
    try {
      await settingsService.saveSettings(
        anonymousMessages: anonymousMessages,
        showTitle: showTitle,
        notifications: notifications,
      );
    } catch (_) {}
  }

  Future<void> changeSetting(bool value, void Function() update) async {
    setState(update);
    await save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: const Text('بلاغاتي'),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyReportsScreen()));
              },
            ),
                ListTile(
                  leading: const Icon(Icons.block_outlined),
                  title: const Text('المستخدمون المحظورون'),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BlockedUsersScreen(),
                      ),
                    );
                  },
                ),
                const Text(
                  'الخصوصية',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                SwitchListTile(
                  title: const Text('استقبال الرسائل المجهولة'),
                  subtitle: const Text(
                    'السماح للآخرين بإرسال رسائل مجهولة إليك',
                  ),
                  value: anonymousMessages,
                  onChanged: (value) =>
                      changeSetting(value, () => anonymousMessages = value),
                ),

                SwitchListTile(
                  title: const Text('إظهار اللقب'),
                  subtitle: const Text('إظهار اللقب المكتسب في ملفك'),
                  value: showTitle,
                  onChanged: (value) =>
                      changeSetting(value, () => showTitle = value),
                ),

                const SizedBox(height: 20),

                const Text(
                  'الإشعارات',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                SwitchListTile(
                  title: const Text('الإشعارات'),
                  subtitle: const Text('تنبيهات الرسائل والأحداث الجديدة'),
                  value: notifications,
                  onChanged: (value) =>
                      changeSetting(value, () => notifications = value),
                ),
              ],
            ),
    );
  }
}
