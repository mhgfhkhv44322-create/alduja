import 'package:supabase_flutter/supabase_flutter.dart';

class CharacterUnlockService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<String>> getUnlockedCharacterIds() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('character_unlocks')
        .select('character_id')
        .eq('user_id', user.id);

    return (data as List)
        .map((row) => row['character_id'].toString())
        .toList();
  }

  Future<void> unlockCharacter(String characterId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('character_unlocks').upsert({
      'user_id': user.id,
      'character_id': characterId,
    });
  }
}
