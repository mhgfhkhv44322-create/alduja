import 'package:supabase_flutter/supabase_flutter.dart';

class BlacksmithService {
  final _db = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getRecipes() async {
    return await _db
        .from('blacksmith_recipes')
        .select()
        .order('required_level');
  }

  Future<List<Map<String, dynamic>>> getJobs() async {
    final user = _db.auth.currentUser;
    if (user == null) return [];

    return await _db
        .from('blacksmith_jobs')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);
  }

  Future<void> createCraftJob(String recipeId, int cost) async {
    final user = _db.auth.currentUser;
    if (user == null) return;

    await _db.from('blacksmith_jobs').insert({
      'user_id': user.id,
      'recipe_id': recipeId,
      'job_type': 'craft',
      'status': 'pending',
      'cost_gold': cost,
    });
  }

  Future<void> repairWeapon(String itemId, int cost) async {
    final user = _db.auth.currentUser;
    if (user == null) return;

    await _db.from('blacksmith_jobs').insert({
      'user_id': user.id,
      'item_id': itemId,
      'job_type': 'repair',
      'status': 'pending',
      'cost_gold': cost,
    });
  }

  Future<void> upgradeWeapon(String itemId, int cost) async {
    final user = _db.auth.currentUser;
    if (user == null) return;

    await _db.from('blacksmith_jobs').insert({
      'user_id': user.id,
      'item_id': itemId,
      'job_type': 'upgrade',
      'status': 'pending',
      'cost_gold': cost,
    });
  }
}
