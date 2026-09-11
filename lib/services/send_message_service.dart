import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/send_message.dart';
import 'message_content_guard.dart';

class SendMessageService {
  final MessageContentGuard _guard = MessageContentGuard();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> send(SendMessage message) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    if (message.receiverId == user.id) {
      throw Exception('ما تكدر ترسل رسالة لنفسك');
    }

    final guardResult = _guard.check(message.text);

    if (!guardResult.allowed) {
      throw Exception(guardResult.reason ?? 'لا يمكن إرسال الرسالة');
    }

    await _supabase.from('messages').insert(
      message.toMap(user.id),
    );
  }
}
