import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/city.dart';

class CityService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<City>> getCities() async {
    final data = await _supabase
        .from('cities')
        .select('id, name')
        .order('name');

    return (data as List)
        .map(
          (row) => City.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }
}
