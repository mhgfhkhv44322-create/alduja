import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/discovered_character.dart';

class DiscoveredCharacterService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<DiscoveredCharacter>> getMyCharacters() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('character_unlocks')
        .select()
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: true);

    return data
        .map<DiscoveredCharacter>(
          (item) => DiscoveredCharacter.fromMap(item),
        )
        .toList();
  }

  Future<bool> isUnlocked(String characterId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final data = await _supabase
        .from('character_unlocks')
        .select('character_id')
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .maybeSingle();

    return data != null;
  }
}
