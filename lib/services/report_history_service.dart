import 'package:supabase_flutter/supabase_flutter.dart';

class ReportHistoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getReports() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('reports')
        .select('id, reported_user_id, reason, created_at')
        .eq('reporter_id', user.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }
}
