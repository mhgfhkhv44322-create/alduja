import 'package:supabase_flutter/supabase_flutter.dart';

class CharacterBrainService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> buildCharacterContext(String characterId) async {
    final character = await _supabase
        .from('characters')
        .select('id, name, title, description')
        .eq('id', characterId)
        .single();

    final memories = await _supabase
        .from('character_memory')
        .select(
          'memory_type, memory_text, importance',
        )
        .eq('character_id', characterId)
        .isFilter('user_id', null)
        .order('importance', ascending: false);

    final knowledge = await _supabase
        .from('lore_character_knowledge')
        .select('''
          knowledge_level,
          reveal_style,
          lore_knowledge (
            knowledge_type,
            knowledge_text,
            difficulty,
            is_public
          )
        ''')
        .eq('character_id', characterId);

    final buffer = StringBuffer();

    buffer.writeln('الشخصية: ${character['name']}');
    buffer.writeln('اللقب: ${character['title']}');
    buffer.writeln('الوصف: ${character['description']}');
    buffer.writeln('');
    buffer.writeln('ذاكرة الشخصية:');

    for (final row in memories as List) {
      buffer.writeln(
        '- ${row['memory_type']}: ${row['memory_text']}',
      );
    }

    buffer.writeln('');
    buffer.writeln('المعرفة التي تملكها الشخصية:');

    for (final row in knowledge as List) {
      final lore = row['lore_knowledge'];

      if (lore is Map && lore['is_public'] == true) {
        buffer.writeln(
          '- ${lore['knowledge_text']} '
          '[مستوى المعرفة: ${row['knowledge_level']}, '
          'أسلوب الكشف: ${row['reveal_style']}]',
        );
      }
    }

    return buffer.toString();
  }
}
