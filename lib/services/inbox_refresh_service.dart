import 'dart:async';
import 'inbox_service.dart';

class InboxRefreshService {
  final InboxService inboxService;

  InboxRefreshService({
    InboxService? inboxService,
  }) : inboxService = inboxService ?? InboxService();

  Timer? _timer;

  void start({
    required Future<void> Function(
      List<Map<String, dynamic>>,
    ) onUpdate,
    Duration interval = const Duration(seconds: 10),
  }) {
    stop();

    _timer = Timer.periodic(interval, (_) async {
      final messages = await inboxService.getInbox();
      await onUpdate(messages);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
  }
}
