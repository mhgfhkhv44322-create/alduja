import 'package:supabase_flutter/supabase_flutter.dart';

class ChatMessagesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMessages(
    String otherUserId,
  ) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('messages')
        .select(
          'id, sender_id, receiver_id, message_text, is_read, created_at',
        )
        .or(
          'and(sender_id.eq.${user.id},receiver_id.eq.$otherUserId),'
          'and(sender_id.eq.$otherUserId,receiver_id.eq.${user.id})',
        )
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(data);
  }
}
