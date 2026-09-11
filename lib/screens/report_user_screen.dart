import 'package:flutter/material.dart';
import '../services/report_user_service.dart';

class ReportUserScreen extends StatefulWidget {
  final String userId;

  const ReportUserScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ReportUserScreen> createState() =>
      _ReportUserScreenState();
}

class _ReportUserScreenState
    extends State<ReportUserScreen> {
  final controller = TextEditingController();
  bool sending = false;

  Future<void> submit() async {
    final reason = controller.text.trim();

    if (reason.isEmpty) return;

    setState(() => sending = true);

    try {
      await ReportUserService().reportUser(
        reportedUserId: widget.userId,
        reason: reason,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال البلاغ'),
        ),
      );

      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر إرسال البلاغ'),
        ),
      );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإبلاغ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'ليش تريد تبلغ عن هذا المستخدم؟',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 6,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText: 'اكتب سبب الإبلاغ...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: sending ? null : submit,
                child: Text(
                  sending ? 'جاري الإرسال...' : 'إرسال البلاغ',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
