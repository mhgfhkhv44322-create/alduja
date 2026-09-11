import 'package:supabase_flutter/supabase_flutter.dart';

class HiddenPlaceService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> isDiscovered(String key) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final row = await _supabase
        .from('user_discoveries')
        .select('id')
        .eq('user_id', user.id)
        .eq('discovery_key', key)
        .maybeSingle();

    return row != null;
  }

  Future<void> discover(String key) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('user_discoveries').upsert({
      'user_id': user.id,
      'discovery_key': key,
    });
  }
}
