import 'package:flutter/material.dart';
import '../services/saved_message_service.dart';

class SaveMessageButton extends StatefulWidget {
  final String messageId;

  const SaveMessageButton({
    super.key,
    required this.messageId,
  });

  @override
  State<SaveMessageButton> createState() =>
      _SaveMessageButtonState();
}

class _SaveMessageButtonState
    extends State<SaveMessageButton> {
  final service = SavedMessageService();

  bool saved = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    checkSaved();
  }

  Future<void> checkSaved() async {
    try {
      final result =
          await service.isSaved(widget.messageId);

      if (!mounted) return;

      setState(() {
        saved = result;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  Future<void> toggle() async {
    if (loading) return;

    setState(() => loading = true);

    try {
      if (saved) {
        await service.unsaveMessage(widget.messageId);
      } else {
        await service.saveMessage(widget.messageId);
      }

      if (!mounted) return;

      setState(() {
        saved = !saved;
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            saved
                ? 'تم حفظ الرسالة'
                : 'تم إلغاء حفظ الرسالة',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر حفظ الرسالة'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: loading ? null : toggle,
      tooltip: saved ? 'إلغاء الحفظ' : 'حفظ الرسالة',
      icon: Icon(
        saved
            ? Icons.bookmark
            : Icons.bookmark_border,
      ),
    );
  }
}
