import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/character_message.dart';

class CharacterMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CharacterMessage>> getMessages(
    String characterId,
  ) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('character_messages')
        .select()
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .order('created_at', ascending: true);

    return data
        .map<CharacterMessage>(
          (item) => CharacterMessage.fromMap(item),
        )
        .toList();
  }

  Future<void> sendMessage({
    required String characterId,
    required String text,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('character_messages').insert({
      'user_id': user.id,
      'character_id': characterId,
      'sender': 'user',
      'message_text': text.trim(),
    });
  }
}
