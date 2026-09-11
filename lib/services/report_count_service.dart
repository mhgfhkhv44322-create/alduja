import 'package:supabase_flutter/supabase_flutter.dart';

class ReportCountService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<int> getMyReportCount() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return 0;

    final data = await _supabase
        .from('reports')
        .select('id')
        .eq('reporter_id', user.id);

    return (data as List).length;
  }
}
