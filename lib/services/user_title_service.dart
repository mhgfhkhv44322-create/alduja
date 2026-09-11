import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_title.dart';

class UserTitleService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserTitle>> getMyTitles() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_titles')
        .select()
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: false);

    return data
        .map<UserTitle>((item) => UserTitle.fromMap(item))
        .toList();
  }

  Future<void> unlockTitle(String titleId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('user_titles').upsert({
      'user_id': user.id,
      'title_id': titleId,
    });
  }
}
