import 'package:supabase_flutter/supabase_flutter.dart';

class CharacterService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCharacters() async {
    final data = await _supabase
        .from('characters')
        .select()
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> getUnlockedCharacters() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('character_unlocks')
        .select('character_id, unlocked_at, characters(*)')
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: true);

    return List<Map<String, dynamic>>.from(data);
  }
}
