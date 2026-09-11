import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/character_unlock.dart';

class CharacterUnlockService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CharacterUnlock>> getMyUnlocks() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('character_unlocks')
        .select()
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: true);

    return data
        .map<CharacterUnlock>(
          (item) => CharacterUnlock.fromMap(item),
        )
        .toList();
  }

  Future<void> unlockCharacter(String characterId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('character_unlocks').upsert({
      'user_id': user.id,
      'character_id': characterId,
    });
  }
}
