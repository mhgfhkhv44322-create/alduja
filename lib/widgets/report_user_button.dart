import 'package:flutter/material.dart';
import '../services/report_user_service.dart';
import '../screens/report_screen.dart';

class ReportUserButton extends StatelessWidget {
  final String userId;

  const ReportUserButton({
    super.key,
    required this.userId,
  });

  Future<void> showReportDialog(BuildContext context) async {
    final controller = TextEditingController();

    final reason = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('الإبلاغ عن المستخدم'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            maxLength: 500,
            decoration: const InputDecoration(
              hintText: 'اكتب سبب الإبلاغ...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(context, controller.text),
              child: const Text('إرسال'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (reason == null || reason.trim().isEmpty) return;

    try {
      await ReportUserService().reportUser(
        reportedUserId: userId,
        reason: reason,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال البلاغ'),
        ),
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر إرسال البلاغ'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'الإبلاغ',
      icon: const Icon(Icons.flag_outlined),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReportScreen(userId: userId),
          ),
        );
      },
    );
  }
}
