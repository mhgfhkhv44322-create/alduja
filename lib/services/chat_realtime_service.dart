import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRealtimeService {
  final SupabaseClient _supabase = Supabase.instance.client;

  RealtimeChannel listen({
    required String otherUserId,
    required void Function(Map<String, dynamic>) onMessage,
  }) {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    final channel = _supabase.channel(
      'chat_${user.id}_$otherUserId',
    );

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final record = payload.newRecord;

            final sender = record['sender_id'];
            final receiver = record['receiver_id'];

            final belongsToChat =
                (sender == user.id && receiver == otherUserId) ||
                (sender == otherUserId && receiver == user.id);

            if (belongsToChat) {
              onMessage(record);
            }
          },
        )
        .subscribe();

    return channel;
  }

  Future<void> stop(RealtimeChannel channel) async {
    await _supabase.removeChannel(channel);
  }
}
