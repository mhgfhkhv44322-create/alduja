import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/conversation.dart';

class ConversationService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Conversation>> getConversations() async {
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
          'sender_id, receiver_id, message_text, created_at, is_read',
        )
        .or(
          'sender_id.eq.${user.id},receiver_id.eq.${user.id}',
        )
        .order('created_at', ascending: false);

    final rows = List<Map<String, dynamic>>.from(data);
    final Map<String, Map<String, dynamic>> latest = {};

    for (final row in rows) {
      final senderId = row['sender_id']?.toString();
      final receiverId = row['receiver_id']?.toString();

      if (senderId == null || receiverId == null) continue;

      final otherId =
          senderId == user.id ? receiverId : senderId;

      if (blockedIds.contains(otherId)) continue;

      latest.putIfAbsent(otherId, () => row);
    }

    if (latest.isEmpty) return [];

    final userIds = latest.keys.toList();

    final profiles = await _supabase
        .from('profiles')
        .select('id, username, display_name')
        .inFilter('id', userIds);

    final profileRows =
        List<Map<String, dynamic>>.from(profiles);

    final profileMap = {
      for (final profile in profileRows)
        profile['id'].toString(): profile,
    };

    return latest.entries.map((entry) {
      final otherId = entry.key;
      final row = entry.value;
      final profile = profileMap[otherId];

      return Conversation(
        userId: otherId,
        username: profile?['username']?.toString(),
        displayName: profile?['display_name']?.toString(),
        lastMessage: row['message_text']?.toString(),
        lastMessageAt: row['created_at'] == null
            ? null
            : DateTime.tryParse(
                row['created_at'].toString(),
              ),
        unreadCount:
            row['receiver_id']?.toString() == user.id &&
                    row['is_read'] == false
                ? 1
                : 0,
      );
    }).toList();
  }
}
