import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message.dart';

class MessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> sendMessage({
    required String receiverId,
    required String text,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('messages').insert({
      'sender_id': user.id,
      'receiver_id': receiverId,
      'message_text': text.trim(),
    });
  }

  Future<List<Message>> getReceivedMessages() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return [];

    final data = await _supabase
        .from('messages')
        .select()
        .eq('receiver_id', user.id)
        .order('created_at', ascending: false);

    return data
        .map<Message>((item) => Message.fromMap(item))
        .toList();
  }
}
