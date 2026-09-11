import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message.dart';

class ChatService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<ChatMessage>> getMessages(String otherUserId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    final data = await _supabase
        .from('messages')
        .select()
        .or(
          'and(sender_id.eq.${user.id},receiver_id.eq.$otherUserId),'
          'and(sender_id.eq.$otherUserId,receiver_id.eq.${user.id})',
        )
        .order('created_at', ascending: true);

    return (data as List)
        .map(
          (item) => ChatMessage.fromMap(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }
}
