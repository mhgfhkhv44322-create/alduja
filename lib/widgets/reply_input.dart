import 'package:flutter/material.dart';

class ReplyInput extends StatefulWidget {
  final Future<void> Function(String text) onSend;

  const ReplyInput({
    super.key,
    required this.onSend,
  });

  @override
  State<ReplyInput> createState() => _ReplyInputState();
}

class _ReplyInputState extends State<ReplyInput> {
  final controller = TextEditingController();
  bool sending = false;

  Future<void> send() async {
    final text = controller.text.trim();

    if (text.isEmpty || sending) return;

    setState(() => sending = true);

    try {
      await widget.onSend(text);
      controller.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceFirst('Exception: ', ''),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => sending = false);
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLength: 2000,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'اكتب ردك...',
                  counterText: '',
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: sending ? null : send,
              icon: sending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
