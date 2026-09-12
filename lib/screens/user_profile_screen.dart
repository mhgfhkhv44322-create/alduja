import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  static const bg = Color(0xFF07080B);
  static const panel = Color(0xFF101115);
  static const gold = Color(0xFFE1BC7A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 35),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined),
                      color: Colors.white70,
                    ),
                    const Spacer(),
                    const Text(
                      'أنا',
                      style: TextStyle(
                        color: gold,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded),
                      color: Colors.white70,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: panel,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF302A20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 94,
                        height: 94,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: gold, width: 1.5),
                          color: const Color(0xFF1A1A1E),
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: gold,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'مستخدم مجهول',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'مستكشف • المستوى 1',
                        style: TextStyle(
                          color: Color(0xFFB39A6C),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'بعض الطرق لا تؤدي إلى مكان… لكنها تقودك إلى حكاية.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9D9DA4),
                          height: 1.7,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _stat('1', 'المستوى'),
                    _stat('0', 'الحكايات'),
                    _stat('0', 'الاكتشافات'),
                  ],
                ),
                const SizedBox(height: 22),
                _title('إنجازاتك'),
                _achievement(Icons.auto_awesome_outlined, 'بداية الطريق',
                    'خطوتك الأولى في الدجى'),
                _achievement(Icons.menu_book_outlined, 'قارئ الحكايات',
                    'اقرأ أول حكاية'),
                const SizedBox(height: 18),
                _title('أشياؤك'),
                _row(Icons.bookmark_border_rounded, 'الحكايات المحفوظة', '0'),
                _row(Icons.nightlight_outlined, 'الأصداء المكتشفة', '0'),
                _row(Icons.location_on_outlined, 'الأماكن المكتشفة', '0'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFF292A2F)),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: gold, fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    color: Color(0xFF77777D), fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 11),
        child: Text(text,
            style: const TextStyle(
                color: gold, fontSize: 19, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _achievement(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFF292A2F)),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF6F6F76), size: 15),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Color(0xFF77777D), fontSize: 11)),
              ],
            ),
          ),
          Icon(icon, color: gold, size: 28),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF292A2F)),
      ),
      child: Row(
        children: [
          Text(value,
              style: const TextStyle(color: Color(0xFF77777D), fontSize: 12)),
          const Spacer(),
          Text(title,
              style: const TextStyle(
                  color: Color(0xFFD0D0D4), fontSize: 13)),
          const SizedBox(width: 12),
          Icon(icon, color: gold, size: 22),
        ],
      ),
    );
  }
}
