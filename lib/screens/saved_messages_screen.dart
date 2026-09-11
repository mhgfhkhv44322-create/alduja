import 'package:flutter/material.dart';

import '../services/saved_messages_service.dart';

class SavedMessagesScreen extends StatefulWidget {
  const SavedMessagesScreen({super.key});

  @override
  State<SavedMessagesScreen> createState() => _SavedMessagesScreenState();
}

class _SavedMessagesScreenState extends State<SavedMessagesScreen> {
  final SavedMessagesService service = SavedMessagesService();

  late Future<List<Map<String, dynamic>>> savedMessages;

  @override
  void initState() {
    super.initState();
    savedMessages = service.getSavedMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرسائل المحفوظة')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: savedMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('تعذر تحميل الرسائل المحفوظة'));
          }

          final messages = snapshot.data ?? [];

          if (messages.isEmpty) {
            return const Center(child: Text('ما عندك رسائل محفوظة بعد'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final message = messages[index];
              final messageId = message['id'].toString();
              final text = message['message_text']?.toString() ?? '';

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: const Text('رسالة محفوظة'),
                  subtitle: Text('معرّف الرسالة: $messageId'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
