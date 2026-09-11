import 'package:supabase_flutter/supabase_flutter.dart';

class InboxService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getInbox() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final blockedRows = await _supabase
        .from('user_blocks')
        .select('blocked_user_id')
        .eq('user_id', user.id);

    final blockedIds = (blockedRows as List)
        .map((row) => row['blocked_user_id'].toString())
        .toSet();

    final data = await _supabase
        .from('messages')
        .select(
          'id, sender_id, receiver_id, message_text, is_read, created_at',
        )
        .eq('receiver_id', user.id)
        .order('created_at', ascending: false);

    final rows = List<Map<String, dynamic>>.from(data);

    return rows
        .where(
          (row) =>
              !blockedIds.contains(
                row['sender_id'].toString(),
              ),
        )
        .toList();
  }
}
