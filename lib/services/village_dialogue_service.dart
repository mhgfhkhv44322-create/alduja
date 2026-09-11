import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/village_dialogue.dart';

class VillageDialogueService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<VillageDialogue>> getDialogues(
    String villageId,
  ) async {
    final data = await _supabase
        .from('village_dialogues')
        .select(
          'id, village_id, speaker_name, dialogue, order_index',
        )
        .eq('village_id', villageId)
        .order('order_index', ascending: true);

    return (data as List)
        .map(
          (row) => VillageDialogue.fromMap(
            Map<String, dynamic>.from(row),
          ),
        )
        .toList();
  }
}
