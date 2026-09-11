import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/story.dart';

class StoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Story>> getStories() async {
    final data = await _supabase
        .from('stories')
        .select('id, title, content, cover_url, city_name, created_at')
        .order('created_at', ascending: false);

    return (data as List)
        .map((row) => Story.fromMap(
              Map<String, dynamic>.from(row),
            ))
        .toList();
  }
}
