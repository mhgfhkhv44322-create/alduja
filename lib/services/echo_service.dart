import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/character_echo.dart';

class EchoService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<CharacterEcho>> getCharacterEchoes(
    String characterId,
  ) async {
    final data = await _supabase
        .from('character_echoes')
        .select()
        .eq('character_id', characterId)
        .order('created_at', ascending: false);

    return data
        .map<CharacterEcho>(
          (item) => CharacterEcho.fromMap(item),
        )
        .toList();
  }
}
