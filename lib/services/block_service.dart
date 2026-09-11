import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/block.dart';

class BlockService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserBlock>> getMyBlocks() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_blocks')
        .select()
        .eq('blocker_id', user.id)
        .order('created_at', ascending: false);

    return data
        .map<UserBlock>((item) => UserBlock.fromMap(item))
        .toList();
  }

  Future<void> blockUser(String blockedId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('user_blocks').upsert({
      'blocker_id': user.id,
      'blocked_id': blockedId,
    });
  }

  Future<void> unblockUser(String blockedId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('user_blocks')
        .delete()
        .eq('blocker_id', user.id)
        .eq('blocked_id', blockedId);
  }
}
