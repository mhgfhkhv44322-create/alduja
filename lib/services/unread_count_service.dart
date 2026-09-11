import 'package:supabase_flutter/supabase_flutter.dart';

class UnreadCountService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<int> getCount() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return 0;
    }

    final data = await _supabase
        .from('messages')
        .select('id')
        .eq('receiver_id', user.id)
        .eq('is_read', false);

    return (data as List).length;
  }
}
