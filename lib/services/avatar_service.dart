import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/avatar.dart';

class AvatarService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Avatar>> getAvatars() async {
    final data = await _supabase
        .from('profile_avatars')
        .select()
        .order('created_at', ascending: true);

    return data
        .map<Avatar>((item) => Avatar.fromMap(item))
        .toList();
  }

  Future<void> setAvatar(String avatarId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('profiles')
        .update({'avatar_id': avatarId})
        .eq('id', user.id);
  }
}
