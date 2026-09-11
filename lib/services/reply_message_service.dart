import 'package:supabase_flutter/supabase_flutter.dart';

class ReplyMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> sendReply({
    required String receiverId,
    required String messageText,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final receiver = receiverId.trim();
    final text = messageText.trim();

    if (receiver.isEmpty) {
      throw Exception('المستخدم غير صالح');
    }

    if (text.isEmpty) {
      throw Exception('الرسالة فارغة');
    }

    if (text.length > 2000) {
      throw Exception('الرسالة طويلة جداً');
    }

    final blockedByReceiver = await _supabase
        .from('user_blocks')
        .select('id')
        .eq('user_id', receiver)
        .eq('blocked_user_id', user.id)
        .maybeSingle();

    final blockedByMe = await _supabase
        .from('user_blocks')
        .select('id')
        .eq('user_id', user.id)
        .eq('blocked_user_id', receiver)
        .maybeSingle();

    if (blockedByReceiver != null || blockedByMe != null) {
      throw Exception('لا يمكن إرسال الرسالة لهذا المستخدم');
    }

    await _supabase.from('messages').insert({
      'sender_id': user.id,
      'receiver_id': receiver,
      'message_text': text,
      'is_read': false,
    });
  }
}
