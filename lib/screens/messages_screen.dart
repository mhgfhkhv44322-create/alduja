import 'package:flutter/material.dart';
import '../services/conversation_service.dart';
import '../models/conversation.dart';
import '../widgets/conversation_tile.dart';
import 'chat_screen.dart';
import 'saved_messages_screen.dart';
import 'blocked_users_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ConversationService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('الرسائل'),
        actions: [
          IconButton(
            tooltip: 'المستخدمون المحظورون',
            icon: const Icon(Icons.block_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const BlockedUsersScreen()));
            },
          ),
          IconButton(
            tooltip: 'الرسائل المحفوظة',
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SavedMessagesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Conversation>>(
        future: service.getConversations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('حدث خطأ في تحميل الرسائل'),
            );
          }

          final conversations = snapshot.data ?? [];

          if (conversations.isEmpty) {
            return const EmptyMessagesView();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: conversations.length,
            separatorBuilder: (_, index) =>
                const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final conversation = conversations[index];

              return ConversationTile(
                conversation: conversation,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        otherUserId: conversation.userId,
                        title: conversation.displayName ??
                            conversation.username,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class EmptyMessagesView extends StatelessWidget {
  const EmptyMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mail_outline,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            const Text(
              'ما عندك رسائل لحد الآن',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'من توصل رسالة راح تظهر هنا.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
