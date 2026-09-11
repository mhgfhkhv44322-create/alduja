import 'package:supabase_flutter/supabase_flutter.dart';

class SavedMessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> saveMessage(String messageId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _supabase.from('user_discoveries').upsert({
      'user_id': user.id,
      'discovery_key': 'saved_message_$messageId',
    });
  }

  Future<void> unsaveMessage(String messageId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('user_discoveries')
        .delete()
        .eq('user_id', user.id)
        .eq('discovery_key', 'saved_message_$messageId');
  }

  Future<bool> isSaved(String messageId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return false;

    final data = await _supabase
        .from('user_discoveries')
        .select('id')
        .eq('user_id', user.id)
        .eq('discovery_key', 'saved_message_$messageId')
        .maybeSingle();

    return data != null;
  }
}
