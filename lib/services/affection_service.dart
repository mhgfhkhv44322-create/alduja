import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/affection.dart';

class AffectionService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<CharacterAffection?> getAffection(String characterId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final data = await _supabase
        .from('character_affection')
        .select()
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .maybeSingle();

    if (data == null) return null;

    return CharacterAffection.fromMap(data);
  }

  Future<void> setAffection({
    required String characterId,
    required int affection,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('character_affection').upsert({
      'user_id': user.id,
      'character_id': characterId,
      'affection': affection,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
