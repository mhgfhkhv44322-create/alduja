import 'package:supabase_flutter/supabase_flutter.dart';

class ChatReadService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> markMessageAsRead(String messageId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('id', messageId)
        .eq('receiver_id', user.id);
  }

  Future<void> markConversationAsRead(String otherUserId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('sender_id', otherUserId)
        .eq('receiver_id', user.id)
        .eq('is_read', false);
  }
}
