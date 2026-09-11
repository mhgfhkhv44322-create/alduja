import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/achievement.dart';

class AchievementService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Achievement>> getAchievements() async {
    final data = await _supabase
        .from('achievements')
        .select()
        .order('created_at', ascending: true);

    return data
        .map<Achievement>((item) => Achievement.fromMap(item))
        .toList();
  }

  Future<List<Achievement>> getMyAchievements() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_achievements')
        .select('achievement_id, unlocked_at, achievements(*)')
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: false);

    return data
        .map<Achievement>(
          (item) => Achievement.fromMap(
            Map<String, dynamic>.from(item['achievements'] as Map),
          ),
        )
        .toList();
  }
}
