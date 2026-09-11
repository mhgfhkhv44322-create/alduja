import 'package:flutter/material.dart';
import '../services/report_service.dart';

class ReportScreen extends StatefulWidget {
  final String userId;

  const ReportScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final controller = TextEditingController();
  String selectedReason = 'محتوى مسيء';
  bool sending = false;

  Future<void> submitReport() async {
    final confirmed = await showDialog<bool>(context: context, builder: (context) => AlertDialog(title: const Text('تأكيد البلاغ'), content: const Text('متأكد تريد إرسال هذا البلاغ؟'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')), FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('إرسال'))],)); if (confirmed != true) return;

    final reason = controller.text.trim().isEmpty ? selectedReason : controller.text.trim();

    if (reason.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('اكتب سبب الإبلاغ بشكل أوضح'),
        ),
      );
      return;
    }

    setState(() => sending = true);

    try {
      await ReportService().reportUser(
        reportedUserId: widget.userId,
        reason: reason,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال البلاغ بنجاح'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
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
        title: const Text('الإبلاغ عن مستخدم'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            const Text(
              'نوع الإبلاغ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: selectedReason,
              items: const [
                DropdownMenuItem(value: 'محتوى مسيء', child: Text('محتوى مسيء')),
                DropdownMenuItem(value: 'تحرش أو إساءة', child: Text('تحرش أو إساءة')),
                DropdownMenuItem(value: 'رسائل مزعجة', child: Text('رسائل مزعجة')),
                DropdownMenuItem(value: 'انتحال شخصية', child: Text('انتحال شخصية')),
                DropdownMenuItem(value: 'سبب آخر', child: Text('سبب آخر')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => selectedReason = value);
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 6,
              maxLength: 500,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'اكتب سبب الإبلاغ...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed:
                  sending ? null : submitReport,
              child: Text(
                sending
                    ? 'جاري الإرسال...'
                    : 'إرسال البلاغ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
