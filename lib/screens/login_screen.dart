import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _hidePassword = true;

  Future<void> _login() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      _showMessage('اكتب البريد الإلكتروني وكلمة المرور');
      return;
    }

    setState(() => _loading = true);

    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        ),
        (route) => false,
      );
    } on AuthException catch (e) {
      _showMessage(
        e.message.isNotEmpty ? e.message : 'تعذر تسجيل الدخول',
      );
    } catch (_) {
      _showMessage('حدث خطأ غير متوقع، حاول مرة أخرى');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _googleLogin() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.alduja://login-callback/',
      );
    } catch (_) {
      _showMessage('تعذر تسجيل الدخول باستخدام Google حالياً');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFF05090D),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/duja_login_bg.png',
            fit: BoxFit.cover,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: .18),
                  Colors.black.withValues(alpha: .58),
                  Colors.black.withValues(alpha: .88),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 35, 28, 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - 63,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      'الدجى',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE8C98F),
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'حكايات بين الظل والنور',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE2D4BC),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 55),

                    _field(
                      controller: _emailController,
                      hint: 'البريد الإلكتروني',
                      icon: Icons.person_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 14),

                    _field(
                      controller: _passwordController,
                      hint: 'كلمة المرور',
                      icon: Icons.lock_outline_rounded,
                      obscureText: _hidePassword,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() => _hidePassword = !_hidePassword);
                        },
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFFCDB27D),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6C88F),
                          foregroundColor: const Color(0xFF17120C),
                          disabledBackgroundColor:
                              const Color(0xFF8F7954),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          elevation: 0,
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 23,
                                height: 23,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFF17120C),
                                ),
                              )
                            : const Text(
                                'دخول إلى الدجى',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withValues(alpha: .18),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'أو',
                            style: TextStyle(
                              color: Color(0xFFCBBFAD),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withValues(alpha: .18),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton.icon(
                        onPressed: _googleLogin,
                        icon: const Text(
                          'G',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        label: const Text(
                          'المتابعة باستخدام Google',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFE4DDD1),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: .22),
                          ),
                          backgroundColor:
                              Colors.black.withValues(alpha: .30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'نسيت كلمة المرور؟',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(0xFFD8BE8A),
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFB99A64),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Text(
                          'إنشاء حساب جديد',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Color(0xFFE3C58D),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'هنا تبدأ الحكاية…',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0xFF9E9588),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textDirection: TextDirection.ltr,
      style: const TextStyle(
        color: Color(0xFFE8E0D4),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(
          color: Color(0xFF827C73),
          fontSize: 15,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFFCDB27D),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.black.withValues(alpha: .34),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: .14),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          borderSide: BorderSide(
            color: Color(0xFFC8A96F),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
