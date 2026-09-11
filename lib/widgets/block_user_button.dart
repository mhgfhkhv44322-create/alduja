import 'package:flutter/material.dart';
import '../services/block_user_service.dart';

class BlockUserButton extends StatefulWidget {
  final String userId;

  const BlockUserButton({
    super.key,
    required this.userId,
  });

  @override
  State<BlockUserButton> createState() => _BlockUserButtonState();
}

class _BlockUserButtonState extends State<BlockUserButton> {
  final BlockUserService _service = BlockUserService();
  bool blocked = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    try {
      final value = await _service.isBlocked(widget.userId);
      if (!mounted) return;
      setState(() {
        blocked = value;
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  Future<void> _toggleBlock() async {
    final action = blocked ? 'إلغاء الحظر' : 'حظر المستخدم';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(action),
          content: Text(
            blocked
                ? 'تريد إلغاء حظر هذا المستخدم؟'
                : 'تريد حظر هذا المستخدم؟',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(action),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      if (blocked) {
        await _service.unblockUser(widget.userId);
      } else {
        await _service.blockUser(widget.userId);
      }

      if (!mounted) return;

      setState(() {
        blocked = !blocked;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            blocked ? 'تم حظر المستخدم' : 'تم إلغاء الحظر',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const IconButton(
        onPressed: null,
        icon: Icon(Icons.block),
      );
    }

    return IconButton(
      tooltip: blocked ? 'إلغاء الحظر' : 'حظر المستخدم',
      icon: Icon(
        blocked ? Icons.block : Icons.block_outlined,
      ),
      onPressed: _toggleBlock,
    );
  }
}
