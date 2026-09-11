import 'package:supabase_flutter/supabase_flutter.dart';

class SadenAiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> sendMessage({
    required String characterId,
    required String message,
  }) async {
    final response = await _supabase.functions.invoke(
      'saden-chat',
      body: {
        'character_id': characterId,
        'message': message,
      },
    );

    final data = response.data;

    if (data is Map && data['error'] != null) {
      throw Exception(data['error'].toString());
    }

    if (data is Map && data['ok'] == true) {
      return 'سياق سادن جاهز';
    }

    throw Exception('تعذر الاتصال بسادن');
  }
}
