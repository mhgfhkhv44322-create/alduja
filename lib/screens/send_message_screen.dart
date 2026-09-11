import 'package:flutter/material.dart';
import '../models/user_search_item.dart';
import '../models/send_message.dart';
import '../services/send_message_service.dart';

class SendMessageScreen extends StatefulWidget {
  final UserSearchItem user;

  const SendMessageScreen({
    super.key,
    required this.user,
  });

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final controller = TextEditingController();
  final service = SendMessageService();
  bool loading = false;

  Future<void> send() async {
    if (controller.text.trim().isEmpty) return;

    setState(() => loading = true);

    try {
      await service.send(
        SendMessage(
          receiverId: widget.user.userId,
          text: controller.text,
        ),
      );

      if (!mounted) return;

      controller.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال الرسالة')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.user.displayName?.trim().isNotEmpty == true
        ? widget.user.displayName!
        : widget.user.username;

    return Scaffold(
      appBar: AppBar(
        title: Text('رسالة إلى $name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              maxLength: 1000,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...' ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: loading ? null : send,
                icon: const Icon(Icons.send),
                label: Text(
                  loading ? 'جاري الإرسال...' : 'إرسال',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
