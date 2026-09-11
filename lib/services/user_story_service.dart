import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_story.dart';

class UserStoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserStory>> getMyReadStories() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_stories')
        .select()
        .eq('user_id', user.id)
        .order('read_at', ascending: false);

    return data
        .map<UserStory>((item) => UserStory.fromMap(item))
        .toList();
  }

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

    final data = await _supabase
        .from('user_stories')
        .select('story_id')
        .eq('user_id', user.id)
        .eq('story_id', storyId)
        .maybeSingle();

    return data != null;
  }
}
