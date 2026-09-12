import 'package:flutter/material.dart';

import '../services/blocked_users_service.dart';
import '../services/block_user_service.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  final blockedService = BlockedUsersService();
  final blockService = BlockUserService();

  late Future<List<Map<String, dynamic>>> users;

  @override
  void initState() {
    super.initState();
    users = blockedService.getBlockedUsers();
  }

  Future<void> unblock(String userId) async {
    await blockService.unblockUser(userId);

    if (!mounted) return;

    setState(() {
      users = blockedService.getBlockedUsers();
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('تم إلغاء الحظر')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المستخدمون المحظورون')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('تعذر تحميل قائمة الحظر'));
          }

          final list = snapshot.data ?? [];

          // قائمة المستخدمين المحظورين جاهزة للإدارة

          if (list.isEmpty) {
            return const Center(child: Text('ماكو مستخدمين محظورين'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = list[index];
              final id = item['id'].toString();
              final name =
                  item['display_name']?.toString() ??
                  item['username']?.toString() ??
                  'مستخدم الدجى';

              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_outline),
                  ),
                  title: Text(name),
                  subtitle: const Text('محظور من مراسلتك'),
                  trailing: TextButton(
                    onPressed: () => unblock(id),
                    child: const Text('إلغاء'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
