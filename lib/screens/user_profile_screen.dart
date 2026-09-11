import 'package:flutter/material.dart';
import '../models/user_search_item.dart';
import 'send_message_screen.dart';

class UserProfileScreen extends StatelessWidget {
  final UserSearchItem user;

  const UserProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final name = user.displayName?.trim().isNotEmpty == true
        ? user.displayName!
        : user.username;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl == null
                  ? const Icon(Icons.person_outline, size: 42)
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text('@${user.username}'),
          ),
          if (user.title != null && user.title!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Center(
              child: Chip(
                label: Text(user.title!),
              ),
            ),
          ],
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SendMessageScreen(user: user),
                ),
              );
            },
            icon: const Icon(Icons.mail_outline),
            label: const Text('إرسال رسالة'),
          ),
        ],
      ),
    );
  }
}
