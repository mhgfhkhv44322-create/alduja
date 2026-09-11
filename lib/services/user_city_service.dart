import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_city.dart';

class UserCityService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserCity>> getMyCities() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('user_cities')
        .select()
        .eq('user_id', user.id)
        .order('discovered_at', ascending: false);

    return data
        .map<UserCity>((item) => UserCity.fromMap(item))
        .toList();
  }

  Future<void> discoverCity({
    required String cityId,
    String? storyId,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    await _supabase.from('user_cities').upsert({
      'user_id': user.id,
      'city_id': cityId,
      if (storyId != null) 'discovered_from_story_id': storyId,
    });
  }
}
