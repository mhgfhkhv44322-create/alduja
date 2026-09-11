import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> getSettings() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final data = await _supabase
        .from('user_settings')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    return data;
  }

  Future<void> saveSettings({
    required bool anonymousMessages,
    required bool showTitle,
    required bool notifications,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('user_settings').upsert({
      'user_id': user.id,
      'anonymous_messages': anonymousMessages,
      'show_title': showTitle,
      'notifications': notifications,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
