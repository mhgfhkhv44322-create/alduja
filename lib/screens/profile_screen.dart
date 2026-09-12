import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const bg = Color(0xFF05080B);
  static const panel = Color(0xFF101316);
  static const gold = Color(0xFFE3C18B);
  static const muted = Color(0xFF9B958C);

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final username =
        user?.userMetadata?['username']?.toString() ??
        user?.email?.split('@').first ??
        'مستخدم مجهول';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'أنا',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined),
              color: Colors.white70,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 35),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: gold.withValues(alpha: .2)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: gold, width: 2),
                        color: const Color(0xFF1A1D20),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: gold,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'مستخدم مجهول',
                      style: TextStyle(color: muted),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        _stat('0', 'حكايات'),
                        _stat('0', 'اكتشافات'),
                        _stat('1', 'المستوى'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              _menu(Icons.auto_awesome_outlined, 'إنجازاتي', 'اكتشافات ورموز الدجى'),
              _menu(Icons.bookmark_outline, 'المحفوظات', 'الحكايات التي احتفظت بها'),
              _menu(Icons.shield_outlined, 'الخصوصية', 'تحكم بهويتك ورسائلك'),
              _menu(Icons.notifications_none_rounded, 'الإشعارات', 'إدارة التنبيهات'),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text('تسجيل الخروج'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent.shade100,
                  side: BorderSide(color: Colors.redAccent.withValues(alpha: .3)),
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String number, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: gold,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: muted, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _menu(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: .07)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF27231D),
            child: Icon(icon, color: gold),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white38, size: 16),
        ],
      ),
    );
  }
}
