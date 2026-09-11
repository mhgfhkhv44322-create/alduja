import 'package:supabase_flutter/supabase_flutter.dart';

class BlockUserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> blockUser(String userId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final id = userId.trim();
    if (id.isEmpty || id == user.id) {
      throw Exception('Invalid user');
    }

    await _supabase.from('user_blocks').upsert({
      'user_id': user.id,
      'blocked_user_id': id,
    });
  }

  Future<void> unblockUser(String userId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('user_blocks')
        .delete()
        .eq('user_id', user.id)
        .eq('blocked_user_id', userId);
  }

  Future<bool> isBlocked(String userId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final data = await _supabase
        .from('user_blocks')
        .select('id')
        .eq('user_id', user.id)
        .eq('blocked_user_id', userId)
        .maybeSingle();

    return data != null;
  }

  Future<List<String>> getBlockedUserIds() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_blocks')
        .select('blocked_user_id')
        .eq('user_id', user.id);

    return (data as List)
        .map((row) => row['blocked_user_id'].toString())
        .toList();
  }
}
