import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationSettingsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> getEnabled() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return true;

    final data = await _supabase
        .from('user_settings')
        .select('notifications')
        .eq('user_id', user.id)
        .maybeSingle();

    return data?['notifications'] != false;
  }

  Future<void> setEnabled(bool enabled) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('user_settings').upsert({
      'user_id': user.id,
      'notifications': enabled,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
