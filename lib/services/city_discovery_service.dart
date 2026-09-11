import 'package:supabase_flutter/supabase_flutter.dart';

class CityDiscoveryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> discoverCity(String cityId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('user_discoveries').upsert({
      'user_id': user.id,
      'discovery_key': 'city_$cityId',
    });
  }

  Future<bool> isDiscovered(String cityId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final result = await _supabase
        .from('user_discoveries')
        .select('id')
        .eq('user_id', user.id)
        .eq('discovery_key', 'city_$cityId')
        .maybeSingle();

    return result != null;
  }
}
