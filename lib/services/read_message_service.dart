import 'package:supabase_flutter/supabase_flutter.dart';

class ReadMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> markAsRead(String messageId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) return;

    await _supabase
        .from('messages')
        .update({'is_read': true})
        .eq('id', messageId)
        .eq('receiver_id', user.id);
  }
}
