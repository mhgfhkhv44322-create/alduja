import 'package:supabase_flutter/supabase_flutter.dart';

class MessageGuardService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> isBlocked(String otherUserId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final blockedByMe = await _supabase
        .from('user_blocks')
        .select('id')
        .eq('blocker_id', user.id)
        .eq('blocked_id', otherUserId)
        .maybeSingle();

    if (blockedByMe != null) return true;

    final blockedMe = await _supabase
        .from('user_blocks')
        .select('id')
        .eq('blocker_id', otherUserId)
        .eq('blocked_id', user.id)
        .maybeSingle();

    return blockedMe != null;
  }
}
