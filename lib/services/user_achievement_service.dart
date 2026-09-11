import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_achievement.dart';

class UserAchievementService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserAchievement>> getMyAchievements() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_achievements')
        .select()
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: false);

    return data
        .map<UserAchievement>(
          (item) => UserAchievement.fromMap(item),
        )
        .toList();
  }

  Future<void> unlockAchievement(String achievementId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('user_achievements').upsert({
      'user_id': user.id,
      'achievement_id': achievementId,
    });
  }
}
