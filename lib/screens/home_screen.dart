import 'package:flutter/material.dart';
import 'stories_screen.dart';
import 'messages_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const bg = Color(0xFF05080B);
  static const panel = Color(0xFF101316);
  static const gold = Color(0xFFE3C18B);
  static const muted = Color(0xFF9B958C);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_rounded),
                      color: Colors.white70,
                    ),
                    const Spacer(),
                    const Text(
                      'الدجى',
                      style: TextStyle(
                        color: gold,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                      color: Colors.white70,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    _topTab('الكل', true),
                    _topTab('الرسائل', false),
                    _topTab('الحكايات', false),
                    _topTab('اكتشف', false),
                  ],
                ),

                const SizedBox(height: 18),

                Container(
                  height: 245,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: gold.withValues(alpha: .22)),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/duja_login_bg.png'),
                      fit: BoxFit.cover,
                      opacity: .58,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Colors.black.withValues(alpha: .92),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'حكاية اليوم',
                          style: TextStyle(color: gold, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'قصر لا ينام',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'بين الرمال والظلال، لا كل القصص مهجورة..',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StoriesScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gold,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('اقرأ الآن'),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(child: _actionCard(Icons.map_outlined, 'الخريطة', 'اكتشف أماكن جديدة')),
                    const SizedBox(width: 10),
                    Expanded(child: _actionCard(Icons.theater_comedy_outlined, 'الشخصيات', 'تعرف على رموز الدجى')),
                    const SizedBox(width: 10),
                    Expanded(child: _actionCard(Icons.auto_awesome_outlined, 'إنجازاتك', 'اكتشف المزيد')),
                  ],
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MessagesScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: gold.withValues(alpha: .16)),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF27231D),
                          child: Icon(Icons.mail_outline, color: gold),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'لديك رسالة جديدة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'وصلك رسالة مجهولة',
                                style: TextStyle(color: muted),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: gold,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'أحدث الحكايات',
                  style: TextStyle(
                    color: gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(child: _storyCard('مدينة تحت الرمال', 'حقيقية')),
                    const SizedBox(width: 12),
                    Expanded(child: _storyCard('الظل الذي عاد', 'تراثية')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topTab(String text, bool selected) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF33291E) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: selected
              ? Border.all(color: gold.withValues(alpha: .35))
              : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? gold : Colors.white54,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _actionCard(IconData icon, String title, String subtitle) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: gold, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _storyCard(String title, String tag) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(tag, style: const TextStyle(color: gold, fontSize: 11)),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
