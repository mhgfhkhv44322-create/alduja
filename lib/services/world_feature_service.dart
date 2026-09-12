import 'package:supabase_flutter/supabase_flutter.dart';

class WorldFeatureService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> isCharacterCreationEnabled() async {
    try {
      final row = await _supabase
          .from('world_features')
          .select('enabled')
          .eq('feature_key', 'world_character_creation')
          .maybeSingle();

      return row?['enabled'] == true;
    } catch (_) {
      // إذا النظام غير مفعّل/غير موجود، يبقى الزر مقفول.
      return false;
    }
  }
}
