import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/character.dart';

class CharacterService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Character>> getCharacters() async {
    final data = await _supabase
        .from('characters')
        .select('id, name, title, description, image_url, created_at')
        .order('name');

    return (data as List)
        .map((row) => Character.fromMap(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<Character> getCharacter(String id) async {
    final data = await _supabase
        .from('characters')
        .select('id, name, title, description, image_url, created_at')
        .eq('id', id)
        .single();

    return Character.fromMap(Map<String, dynamic>.from(data));
  }
}
