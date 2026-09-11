import 'package:flutter/material.dart';

class BlockedUserNotice extends StatelessWidget {
  const BlockedUserNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest,
      ),
      child: const Row(
        children: [
          Icon(Icons.block_outlined),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'هذا المستخدم محظور. ألغِ الحظر حتى تتمكن من مراسلته.',
            ),
          ),
        ],
      ),
    );
  }
}
