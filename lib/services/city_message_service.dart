import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/city_message.dart';

class CityMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CityMessage>> getMessages(String cityId) async {
    final data = await _supabase
        .from('city_messages')
        .select()
        .eq('city_id', cityId)
        .order('created_at', ascending: true);

    return data
        .map<CityMessage>((item) => CityMessage.fromMap(item))
        .toList();
  }

  Future<void> sendMessage({
    required String cityId,
    required String text,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('city_messages').insert({
      'city_id': cityId,
      'user_id': user.id,
      'message_text': text.trim(),
    });
  }
}
