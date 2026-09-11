import 'package:supabase_flutter/supabase_flutter.dart';

class StoryReadService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> markAsRead(String storyId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('user_stories').upsert({
      'user_id': user.id,
      'story_id': storyId,
    });
  }

  Future<bool> isRead(String storyId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final row = await _supabase
        .from('user_stories')
        .select('id')
        .eq('user_id', user.id)
        .eq('story_id', storyId)
        .maybeSingle();

    return row != null;
  }
}
