import 'package:supabase_flutter/supabase_flutter.dart';

class BlockedUsersService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getBlockedUsers() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_blocks')
        .select('blocked_user_id')
        .eq('user_id', user.id);

    final rows = List<Map<String, dynamic>>.from(data);
    final ids = rows.map((row) => row['blocked_user_id'].toString()).toList();

    if (ids.isEmpty) return [];

    final profiles = await _supabase
        .from('profiles')
        .select('id, username, display_name')
        .inFilter('id', ids);

    return List<Map<String, dynamic>>.from(profiles);
  }
}
