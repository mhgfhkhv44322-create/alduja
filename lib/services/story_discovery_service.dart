import 'package:supabase_flutter/supabase_flutter.dart';

class StoryDiscoveryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> discoverStory(String storyId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('user_discoveries').upsert({
      'user_id': user.id,
      'discovery_key': 'story_$storyId',
    });
  }

  Future<bool> isDiscovered(String storyId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final row = await _supabase
        .from('user_discoveries')
        .select('id')
        .eq('user_id', user.id)
        .eq('discovery_key', 'story_$storyId')
        .maybeSingle();

    return row != null;
  }
}
