import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_search_filter.dart';
import '../models/user_search_item.dart';

class UserSearchService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserSearchItem>> search(
    UserSearchFilter filter,
  ) async {
    if (filter.isEmpty) return [];

    final userId = filter.userId?.trim();

    // الـ ID بحث دقيق، وأولوية أعلى من باقي المعايير.
    if (userId != null && userId.isNotEmpty) {
      final data = await _supabase
          .from('profiles')
          .select(
            'id, username, display_name, avatar_url, title',
          )
          .eq('id', userId)
          .limit(1);

      return (data as List)
          .map(
            (item) => UserSearchItem.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    }

    var query = _supabase
        .from('profiles')
        .select(
          'id, username, display_name, avatar_url, title',
        );

    // الاسم: بحث مرن داخل الاسم.
    if (filter.name != null && filter.name!.trim().isNotEmpty) {
      query = query.ilike(
        'display_name',
        '%${filter.name!.trim()}%',
      );
    }

    // اللقب: أي لقب يحتوي على كلمة البحث.
    if (filter.title != null && filter.title!.trim().isNotEmpty) {
      query = query.ilike(
        'title',
        '%${filter.title!.trim()}%',
      );
    }

    final data = await query.limit(50);

    return (data as List)
        .map(
          (item) => UserSearchItem.fromMap(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }
}
