import 'package:supabase_flutter/supabase_flutter.dart';

class SavedMessagesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getSavedMessages() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_discoveries')
        .select('id, discovery_key')
        .eq('user_id', user.id)
        .like('discovery_key', 'saved_message_%');

    return List<Map<String, dynamic>>.from(data);
  }
}
