import 'package:supabase_flutter/supabase_flutter.dart';

class MyReportsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getMyReports() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('reports')
        .select('id, reported_user_id, reason, created_at')
        .eq('reporter_id', user.id)
        .order('created_at', ascending: false)
        .limit(50);

    return List<Map<String, dynamic>>.from(data);
  }
}
