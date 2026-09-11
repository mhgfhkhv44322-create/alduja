import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/anonymous_message.dart';

class AnonymousMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> send({
    required String receiverId,
    required String text,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    final cleanText = text.trim();

    if (cleanText.isEmpty) {
      throw Exception('الرسالة فارغة');
    }

    await _supabase.from('messages').insert({
      'sender_id': user.id,
      'receiver_id': receiverId,
      'message_text': cleanText,
    });
  }

  Future<List<AnonymousMessage>> getReceived() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('messages')
        .select()
        .eq('receiver_id', user.id)
        .order('created_at', ascending: false);

    return data
        .map<AnonymousMessage>(
          (item) => AnonymousMessage.fromMap(item),
        )
        .toList();
  }

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
