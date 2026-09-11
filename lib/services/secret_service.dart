import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/character_secret.dart';

class SecretService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CharacterSecret>> getCharacterSecrets(
    String characterId,
  ) async {
    final data = await _supabase
        .from('character_secrets')
        .select()
        .eq('character_id', characterId)
        .order('required_affection', ascending: true);

    return data
        .map<CharacterSecret>(
          (item) => CharacterSecret.fromMap(item),
        )
        .toList();
  }
}
