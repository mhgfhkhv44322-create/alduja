import 'package:supabase_flutter/supabase_flutter.dart';

class SadenAiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getConversation({
    required String characterId,
    int limit = 30,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    final data = await _supabase
        .from('character_messages')
        .select('sender, message_text, created_at')
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .order('created_at', ascending: true)
        .limit(limit);

    return (data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<String> sendMessage({
    required String characterId,
    required String message,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('يجب تسجيل الدخول أولاً');
    }

    final cleanMessage = message.trim();

    if (cleanMessage.isEmpty) {
      throw Exception('الرسالة فارغة');
    }

    if (cleanMessage.length > 1000) {
      throw Exception('الرسالة طويلة جدًا');
    }

    // جلسة سادن اليومية:
    // يسمح بمحادثة واحدة في اليوم، مع عدد رسائل كافٍ حتى تكون الجلسة فعلية.
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startIso = startOfDay.toUtc().toIso8601String();

    final todayMessages = await _supabase
        .from('character_messages')
        .select('id')
        .eq('user_id', user.id)
        .eq('character_id', characterId)
        .eq('sender', 'user')
        .gte('created_at', startIso);

    if ((todayMessages as List).length >= 20) {
      throw Exception(
        'انتهى مجلس سادن لهذا اليوم. عد إليه غدًا، فبعض الحكايات تحتاج وقتًا.',
      );
    }

    final response = await _supabase.functions.invoke(
      'saden-chat',
      body: {
        'character_id': characterId,
        'message': cleanMessage,
      },
    );

    final data = response.data;

    if (data is Map && data['ok'] == true) {
      return data['reply']?.toString() ?? '';
    }

    final error = data is Map ? data['error']?.toString() : null;

    throw Exception(error ?? 'تعذر الوصول إلى سادن');
  }
}
