import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/frame.dart';

class FrameService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<ProfileFrame>> getFrames() async {
    final data = await _supabase
        .from('profile_frames')
        .select()
        .order('created_at', ascending: true);

    return data
        .map<ProfileFrame>((item) => ProfileFrame.fromMap(item))
        .toList();
  }

  Future<void> setFrame(String frameId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase
        .from('profiles')
        .update({'frame_id': frameId})
        .eq('id', user.id);
  }
}
