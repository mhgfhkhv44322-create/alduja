import 'package:supabase_flutter/supabase_flutter.dart';
import 'character_brain_service.dart';

class CharacterConversationService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final CharacterBrainService _brain = CharacterBrainService();

  Future<List<Map<String, dynamic>>> getRecentMessages(
    String characterId, {
    int limit = 20,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return [];
    }

    final data = await _supabase
        .from('character_messages')
        .select(
          'sender, message_text, created_at',
        )
        .eq('character_id', characterId)
        .eq('user_id', user.id)
        .order('created_at', ascending: false)
        .limit(limit);

    return (data as List)
        .map((row) => Map<String, dynamic>.from(row))
        .toList()
        .reversed
        .toList();
  }

  Future<String> buildConversationContext(
    String characterId,
  ) async {
    final brain = await _brain.buildCharacterContext(characterId);
    final messages = await getRecentMessages(characterId);

    final buffer = StringBuffer();

    buffer.writeln('=== عقل الشخصية ===');
    buffer.writeln(brain);
    buffer.writeln('');
    buffer.writeln('=== المحادثة السابقة ===');

    for (final message in messages) {
      final sender = message['sender'] ?? 'unknown';
      final text = message['message_text'] ?? '';

      buffer.writeln('$sender: $text');
    }

    return buffer.toString();
  }

  Future<void> saveUserMessage(
    String characterId,
    String text,
  ) async {
    final user = _supabase.auth.currentUser;

    if (user == null || text.trim().isEmpty) {
      return;
    }

    await _supabase.from('character_messages').insert({
      'user_id': user.id,
      'character_id': characterId,
      'sender': 'user',
      'message_text': text.trim(),
    });
  }

  Future<void> saveCharacterMessage(
    String characterId,
    String text,
  ) async {
    final user = _supabase.auth.currentUser;

    if (user == null || text.trim().isEmpty) {
      return;
    }

    await _supabase.from('character_messages').insert({
      'user_id': user.id,
      'character_id': characterId,
      'sender': 'character',
      'message_text': text.trim(),
    });
  }
}
