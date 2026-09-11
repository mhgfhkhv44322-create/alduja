import 'package:supabase_flutter/supabase_flutter.dart';

class CityChatService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMessages(
    String cityId,
  ) async {
    final data = await _supabase
        .from('city_messages')
        .select(
          'id, city_id, user_id, message_text, created_at',
        )
        .eq('city_id', cityId)
        .order('created_at', ascending: true)
        .limit(100);

    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> sendMessage({
    required String cityId,
    required String text,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final message = text.trim();

    if (message.isEmpty) {
      throw Exception('اكتب رسالة أولاً');
    }

    if (message.length > 500) {
      throw Exception('الرسالة طويلة جداً');
    }

    await _supabase.from('city_messages').insert({
      'city_id': cityId,
      'user_id': user.id,
      'message_text': message,
    });
  }
}
