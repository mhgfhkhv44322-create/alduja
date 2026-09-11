import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<AuthState> get stream {
    return _supabase.auth.onAuthStateChange;
  }

  Session? get session {
    return _supabase.auth.currentSession;
  }

  User? get user {
    return _supabase.auth.currentUser;
  }

  bool get authenticated {
    return session != null;
  }
}
