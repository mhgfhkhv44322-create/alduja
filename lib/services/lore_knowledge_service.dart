import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lore_knowledge.dart';

class LoreKnowledgeService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<LoreKnowledge>> getPublicKnowledge() async {
    final data = await _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public',
        )
        .eq('is_public', true)
        .order('difficulty')
        .order('created_at');

    return (data as List)
        .map(
          (row) => LoreKnowledge.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }

  Future<List<LoreKnowledge>> getKnowledgeForCity(String cityId) async {
    final data = await _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public',
        )
        .eq('city_id', cityId)
        .eq('is_public', true)
        .order('difficulty')
        .order('created_at');

    return (data as List)
        .map(
          (row) => LoreKnowledge.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }

  Future<List<LoreKnowledge>> getKnowledgeForVillage(
    String villageId,
  ) async {
    final data = await _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public',
        )
        .eq('village_id', villageId)
        .eq('is_public', true)
        .order('difficulty')
        .order('created_at');

    return (data as List)
        .map(
          (row) => LoreKnowledge.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }
}
