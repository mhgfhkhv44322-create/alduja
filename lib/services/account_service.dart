import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';

class AccountService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Profile?> getProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final data = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) return null;

    return Profile.fromMap(data);
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
    String? avatarUrl,
    String? title,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('profiles').update({
      'display_name': ?displayName,
      'bio': ?bio,
      'avatar_url': ?avatarUrl,
      'title': ?title,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
