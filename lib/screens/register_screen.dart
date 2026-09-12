import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _loading = false;
  bool _hidePassword = true;
  bool _hideConfirm = true;
  bool _accepted = false;

  Future<void> _register() async {
    if (_username.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _password.text.isEmpty) {
      _message('أكمل البيانات أولاً');
      return;
    }

    if (_password.text != _confirmPassword.text) {
      _message('كلمتا المرور غير متطابقتين');
      return;
    }

    if (!_accepted) {
      _message('يجب الموافقة على الشروط وسياسة الخصوصية');
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: _email.text.trim(),
        password: _password.text,
        data: {
          'username': _username.text.trim(),
          'display_name': _username.text.trim(),
        },
      );

      if (!mounted) return;

      if (response.session != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigation(),
          ),
          (_) => false,
        );
      } else {
        _message('تم إنشاء الحساب. تحقق من بريدك الإلكتروني لتأكيده.');
      }
    } on AuthException catch (e) {
      _message(e.message);
    } catch (_) {
      _message('تعذر إنشاء الحساب حالياً');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _googleRegister() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.alduja://login-callback/',
      );
    } catch (_) {
      _message('تعذر التسجيل باستخدام Google حالياً');
    }
  }

  void _message(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Colors.black.withValues(alpha: .22),
                  Colors.black.withValues(alpha: .62),
                  Colors.black.withValues(alpha: .94),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 18, 26, 30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFFE1C38C),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'إنشاء حساب جديد',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xFFE7C991),
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'ادخل إلى عالم الدجى',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xFFB4AA9A),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: 108,
                    height: 108,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: .32),
                      border: Border.all(
                        color: const Color(0xFFC8A96F),
                        width: 1.2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Color(0xFFD7B77A),
                      size: 43,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'صورة شخصية اختيارية',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xFFAAA195),
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 25),

                  _field(
                    controller: _username,
                    hint: 'اسم المستخدم',
                    icon: Icons.person_outline_rounded,
                  ),

                  const SizedBox(height: 13),

                  _field(
                    controller: _email,
                    hint: 'البريد الإلكتروني',
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 13),

                  _field(
                    controller: _password,
                    hint: 'كلمة المرور',
                    icon: Icons.lock_outline_rounded,
                    obscure: _hidePassword,
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

                  const SizedBox(height: 13),

                  _field(
                    controller: _confirmPassword,
                    hint: 'تأكيد كلمة المرور',
                    icon: Icons.lock_outline_rounded,
                    obscure: _hideConfirm,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() => _hideConfirm = !_hideConfirm);
                      },
                      icon: Icon(
                        _hideConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFFCDB27D),
                      ),
                    ),
                  ),

                  const SizedBox(height: 17),

                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(
                        value: _accepted,
                        activeColor: const Color(0xFFCBA96D),
                        checkColor: const Color(0xFF17120C),
                        side: const BorderSide(
                          color: Color(0xFFBCA47B),
                        ),
                        onChanged: (value) {
                          setState(() => _accepted = value ?? false);
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'أوافق على الشروط والأحكام وسياسة الخصوصية',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Color(0xFFC4BBAE),
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6C88F),
                        foregroundColor: const Color(0xFF17120C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        elevation: 0,
                      ),
                      child: _loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: Color(0xFF17120C),
                              ),
                            )
                          : const Text(
                              'إنشاء الحساب',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withValues(alpha: .16),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Text(
                          'أو',
                          style: TextStyle(
                            color: Color(0xFFAAA093),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withValues(alpha: .16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 17),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: _googleRegister,
                      icon: const Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      label: const Text(
                        'التسجيل باستخدام Google',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(0xFFE0D9CE),
                          fontSize: 15,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black.withValues(alpha: .30),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: .20),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'لديك حساب بالفعل؟ تسجيل الدخول',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0xFFD4B77D),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
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
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
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
