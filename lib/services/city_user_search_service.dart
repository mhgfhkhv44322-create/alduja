import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_search_item.dart';

class CityUserSearchService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserSearchItem>> searchByCity(String cityId) async {
    final data = await _supabase
        .from('user_cities')
        .select(
          'user_id, profiles(id, username, display_name, avatar_url, title)',
        )
        .eq('city_id', cityId)
        .limit(50);

    return (data as List).map((item) {
      final profile = Map<String, dynamic>.from(
        item['profiles'] as Map,
      );

      return UserSearchItem.fromMap(profile);
    }).toList();
  }
}
