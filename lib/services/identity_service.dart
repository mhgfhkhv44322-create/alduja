import 'package:supabase_flutter/supabase_flutter.dart';

class IdentityService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> setIdentity({
    String? avatarId,
    String? frameId,
    String? titleId,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('profiles').update({
      if (avatarId != null) 'avatar_id': avatarId,
      if (frameId != null) 'frame_id': frameId,
      if (titleId != null) 'title_id': titleId,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);
  }
}
