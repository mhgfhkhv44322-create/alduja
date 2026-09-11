import 'package:supabase_flutter/supabase_flutter.dart';

class StoryCityService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> getCityName(String storyId) async {
    final data = await _supabase
        .from('story_cities')
        .select('city_id')
        .eq('story_id', storyId)
        .maybeSingle();

    if (data == null || data['city_id'] == null) {
      return null;
    }

    final city = await _supabase
        .from('cities')
        .select('name')
        .eq('id', data['city_id'])
        .maybeSingle();

    return city?['name']?.toString();
  }
}
