import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/world_item.dart';

class WorldItemService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<WorldItem>> getItemDefinitions() async {
    final data = await _supabase
        .from('item_definitions')
        .select()
        .order('name');

    return (data as List)
        .map((row) => WorldItem.fromMap(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getMyInventory() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final data = await _supabase
        .from('player_inventory')
        .select('*, item_definitions(*)')
        .eq('user_id', user.id)
        .order('acquired_at', ascending: false);

    return (data as List)
        .map((row) => Map<String, dynamic>.from(row))
        .toList();
  }
}
