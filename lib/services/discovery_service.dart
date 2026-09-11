import 'package:supabase_flutter/supabase_flutter.dart';

class DiscoveryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getDiscoveries() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_discoveries')
        .select('id, discovery_key, discovered_at')
        .eq('user_id', user.id)
        .order('discovered_at', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }
}
