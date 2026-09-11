import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/auth_result.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return AuthResult.failure('تعذر تسجيل الدخول');
      }

      return AuthResult.success(user.id);
    } on AuthException catch (e) {
      return AuthResult.failure(e.message);
    } catch (e) {
      return AuthResult.failure('حدث خطأ أثناء تسجيل الدخول');
    }
  }

  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'username': username.trim()},
      );

      final user = response.user;

      if (user == null) {
        return AuthResult.failure('تعذر إنشاء الحساب');
      }

      return AuthResult.success(user.id);
    } on AuthException catch (e) {
      return AuthResult.failure(e.message);
    } catch (e) {
      return AuthResult.failure('حدث خطأ أثناء إنشاء الحساب');
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
