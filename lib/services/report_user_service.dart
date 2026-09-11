import 'package:supabase_flutter/supabase_flutter.dart';

class ReportUserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> reportUser({
    required String reportedUserId,
    required String reason,
  }) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    if (reportedUserId == user.id) {
      throw Exception('Cannot report yourself');
    }

    final text = reason.trim();

    if (text.isEmpty) {
      throw Exception('سبب الإبلاغ فارغ');
    }

    await _supabase.from('reports').insert({
      'reporter_id': user.id,
      'reported_user_id': reportedUserId,
      'reason': text,
    });
  }
}
