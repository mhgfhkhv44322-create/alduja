import 'package:supabase_flutter/supabase_flutter.dart';

class CurrentUserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  User? get user => _supabase.auth.currentUser;

  String? get userId => user?.id;

  String? get email => user?.email;

  bool get isLoggedIn => user != null;
}
