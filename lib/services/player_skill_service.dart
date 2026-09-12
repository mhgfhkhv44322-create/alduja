import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/player_skill.dart';

class PlayerSkillService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<PlayerSkill>> getSkillTree() async {
    final data = await _supabase
        .from('skill_definitions')
        .select()
        .eq('is_active', true)
        .order('category')
        .order('required_level');

    return (data as List)
        .map((row) => PlayerSkill.fromMap(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<List<PlayerSkill>> getMySkills() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('player_skills')
        .select('rank, skill_definitions(*)')
        .eq('user_id', user.id);

    return (data as List).map((row) {
      final skill = Map<String, dynamic>.from(row['skill_definitions'] ?? {});
      skill['rank'] = row['rank'] ?? 0;
      skill['unlocked'] = true;
      return PlayerSkill.fromMap(skill);
    }).toList();
  }
}
