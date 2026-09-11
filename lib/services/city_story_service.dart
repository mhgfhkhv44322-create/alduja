import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/story.dart';

class CityStoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Story>> getStoriesForCity(String cityId) async {
    final links = await _supabase
        .from('story_cities')
        .select('story_id')
        .eq('city_id', cityId);

    final ids = (links as List)
        .map((row) => row['story_id']?.toString())
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toList();

    if (ids.isEmpty) return [];

    final data = await _supabase
        .from('stories')
        .select(
          'id, title, content, cover_url, city_name, created_at',
        )
        .inFilter('id', ids)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (row) => Story.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }
}
