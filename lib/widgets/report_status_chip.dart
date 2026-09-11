import 'package:flutter/material.dart';

class ReportStatusChip extends StatelessWidget {
  const ReportStatusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Chip(
        avatar: Icon(
          Icons.hourglass_empty,
          size: 18,
        ),
        label: Text('قيد المراجعة'),
      ),
    );
  }
}
