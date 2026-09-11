import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/title.dart';

class TitleService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserTitle>> getTitles() async {
    final data = await _supabase
        .from('titles')
        .select()
        .order('created_at', ascending: true);

    return data
        .map<UserTitle>((item) => UserTitle.fromMap(item))
        .toList();
  }

  Future<List<UserTitle>> getMyTitles() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_titles')
        .select('title_id, unlocked_at, titles(*)')
        .eq('user_id', user.id)
        .order('unlocked_at', ascending: false);

    return data
        .where((item) => item['titles'] != null)
        .map<UserTitle>(
          (item) => UserTitle.fromMap(
            Map<String, dynamic>.from(item['titles'] as Map),
          ),
        )
        .toList();
  }
}
