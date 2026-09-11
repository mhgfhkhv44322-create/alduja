import 'package:supabase_flutter/supabase_flutter.dart';

class ReportService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> reportUser({
    required String reportedUserId,
    required String reason,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final reportedId = reportedUserId.trim();
    final text = reason.trim();

    if (reportedId.isEmpty || reportedId == user.id) {
      throw Exception('Invalid reported user');
    }

    if (text.length < 3) {
      throw Exception('سبب الإبلاغ قصير جداً');
    }

    if (text.length > 500) {
      throw Exception('سبب الإبلاغ طويل جداً');
    }

    final existing = await _supabase
        .from('reports')
        .select('id')
        .eq('reporter_id', user.id)
        .eq('reported_user_id', reportedId)
        .eq('reason', text)
        .maybeSingle();

    if (existing != null) {
      throw Exception('تم إرسال بلاغ مشابه مسبقاً');
    }

    await _supabase.from('reports').insert({
      'reporter_id': user.id,
      'reported_user_id': reportedId,
      'reason': text,
    });
  }
}
