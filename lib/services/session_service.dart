import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/session_state.dart';

class SessionService {
  final SupabaseClient _supabase = Supabase.instance.client;

  SessionState get current {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return const SessionState.loggedOut();
    }

    return SessionState.loggedIn(user.id);
  }

  Stream<AuthState> get changes {
    return _supabase.auth.onAuthStateChange;
  }
}
