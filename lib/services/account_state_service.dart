import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/account_state.dart';

class AccountStateService {
  final SupabaseClient _supabase = Supabase.instance.client;

  AccountState get current {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return AccountState.loggedOut();
    }

    return AccountState.loggedIn(
      userId: user.id,
      email: user.email,
    );
  }

  Stream<AuthState> get authChanges {
    return _supabase.auth.onAuthStateChange;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
