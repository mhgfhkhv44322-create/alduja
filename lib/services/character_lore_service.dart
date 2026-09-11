import 'package:supabase_flutter/supabase_flutter.dart';

class CharacterLoreService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getKnowledgeForCharacter(
    String characterId,
  ) async {
    final data = await _supabase
        .from('lore_character_knowledge')
        .select('''
          id,
          lore_id,
          character_id,
          knowledge_level,
          reveal_style,
          lore_knowledge (
            id,
            knowledge_type,
            knowledge_text,
            source_name,
            difficulty,
            is_public
          )
        ''')
        .eq('character_id', characterId);

    return (data as List)
        .map((row) => Map<String, dynamic>.from(row))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getDiscoveriesForCharacter(
    String characterId,
  ) async {
    final data = await _supabase
        .from('lore_character_knowledge')
        .select('''
          lore_id,
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

    final loreIds = <String>{};

    for (final row in data as List) {
      final loreId = row['lore_id'];
      if (loreId is String) {
        loreIds.add(loreId);
      }
    }

    if (loreIds.isEmpty) {
      return [];
    }

    final discoveries = await _supabase
        .from('lore_discoveries')
        .select('''
          id,
          lore_id,
          discovery_key,
          discovery_title,
          discovery_description,
          required_fragments
        ''')
        .inFilter('lore_id', loreIds.toList());

    return (discoveries as List)
        .map((row) => Map<String, dynamic>.from(row))
        .toList();
  }
}
