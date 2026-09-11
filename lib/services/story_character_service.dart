import 'package:supabase_flutter/supabase_flutter.dart';

class StoryCharacterService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCharacters(
    String storyId,
  ) async {
    final links = await _supabase
        .from('story_characters')
        .select('character_id')
        .eq('story_id', storyId);

    final ids = (links as List)
        .map((row) => row['character_id']?.toString())
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toList();

    if (ids.isEmpty) return [];

    final characters = await _supabase
        .from('characters')
        .select('id, name, title, image_url')
        .inFilter('id', ids);

    return List<Map<String, dynamic>>.from(characters);
  }
}
