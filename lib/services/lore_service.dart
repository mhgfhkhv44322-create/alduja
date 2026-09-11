import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lore_knowledge.dart';

class LoreService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<LoreKnowledge>> getPublicLore() async {
    final data = await _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public, created_at',
        )
        .eq('is_public', true)
        .order('difficulty')
        .order('created_at');

    return (data as List)
        .map((row) => LoreKnowledge.fromMap(
              Map<String, dynamic>.from(row),
            ))
        .toList();
  }

  Future<List<LoreKnowledge>> getCityLore(String cityId) async {
    final data = await _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public, created_at',
        )
        .eq('city_id', cityId)
        .eq('is_public', true)
        .order('difficulty')
        .order('created_at');

    return (data as List)
        .map((row) => LoreKnowledge.fromMap(
              Map<String, dynamic>.from(row),
            ))
        .toList();
  }

  Future<List<LoreKnowledge>> getVillageLore(String villageId) async {
    final data = await _supabase
        .from('lore_knowledge')
        .select(
          'id, story_id, city_id, village_id, knowledge_type, '
          'knowledge_text, source_name, difficulty, is_public, created_at',
        )
        .eq('village_id', villageId)
        .eq('is_public', true)
        .order('difficulty')
        .order('created_at');

    return (data as List)
        .map((row) => LoreKnowledge.fromMap(
              Map<String, dynamic>.from(row),
            ))
        .toList();
  }
}
