import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/village.dart';

class VillageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Village>> getVillagesForCity(String cityId) async {
    final data = await _supabase
        .from('villages')
        .select('id, city_id, name, description')
        .eq('city_id', cityId)
        .order('name');

    return (data as List)
        .map(
          (row) => Village.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }
}
