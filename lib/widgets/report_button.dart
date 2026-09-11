import 'package:flutter/material.dart';
import '../screens/report_screen.dart';

class ReportButton extends StatelessWidget {
  final String userId;

  const ReportButton({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'الإبلاغ عن المستخدم',
      icon: const Icon(Icons.flag_outlined),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReportScreen(userId: userId),
          ),
        );
      },
    );
  }
}
