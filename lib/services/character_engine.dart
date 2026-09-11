import 'package:supabase_flutter/supabase_flutter.dart';

class CharacterEngine {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getCharacter(String characterId) async {
    final data = await _supabase
        .from('characters')
        .select('id, name, title, description, image_url')
        .eq('id', characterId)
        .single();

    return Map<String, dynamic>.from(data);
  }

  Future<List<Map<String, dynamic>>> getCharacterMemory(
    String characterId,
  ) async {
    final data = await _supabase
        .from('character_memory')
        .select('memory_type, memory_text, importance, source')
        .eq('character_id', characterId)
        .isFilter('user_id', null)
        .order('importance', ascending: false);

    return (data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getCharacterKnowledge(
    String characterId,
  ) async {
    final data = await _supabase
        .from('lore_character_knowledge')
        .select('''
          knowledge_level,
          reveal_style,
          lore_knowledge (
            id,
            knowledge_type,
            knowledge_text,
            difficulty,
            is_public
          )
        ''')
        .eq('character_id', characterId);

    return (data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .where((e) => e['lore_knowledge'] != null)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getConversation(
    String characterId, {
    int limit = 30,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('character_messages')
        .select('sender, message_text, created_at')
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .order('created_at', ascending: true)
        .limit(limit);

    return (data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<bool> canTalkToday(String characterId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);

    final data = await _supabase
        .from('character_messages')
        .select('id')
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .eq('sender', 'user')
        .gte('created_at', start.toUtc().toIso8601String());

    return (data as List).length < 20;
  }
}
