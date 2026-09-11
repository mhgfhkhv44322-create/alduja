import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lore_knowledge.dart';

class LoreKnowledgeService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<LoreKnowledge>> getPublicKnowledge({
    String? cityId,
    String? villageId,
    String? storyId,
  }) async {
    var query = _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public, created_at',
        )
        .eq('is_public', true);

    if (cityId != null) {
      query = query.eq('city_id', cityId);
    }

    if (villageId != null) {
      query = query.eq('village_id', villageId);
    }

    if (storyId != null) {
      query = query.eq('story_id', storyId);
    }

    final data = await query.order('difficulty');

    return (data as List)
        .map(
          (row) => LoreKnowledge.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }
}
