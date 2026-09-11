import 'package:supabase_flutter/supabase_flutter.dart';

class UnreadMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<int> getUnreadCount() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return 0;

    final blockedRows = await _supabase
        .from('user_blocks')
        .select('blocked_user_id')
        .eq('user_id', user.id);

    final blockedIds = (blockedRows as List)
        .map((row) => row['blocked_user_id'].toString())
        .toSet();

    final data = await _supabase
        .from('messages')
        .select('id, sender_id')
        .eq('receiver_id', user.id)
        .eq('is_read', false);

    final rows = List<Map<String, dynamic>>.from(data);

    return rows
        .where(
          (row) =>
              !blockedIds.contains(
                row['sender_id'].toString(),
              ),
        )
        .length;
  }
}
