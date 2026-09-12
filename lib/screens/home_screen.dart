import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const bg = Color(0xFF07080B);
  static const panel = Color(0xFF101115);
  static const gold = Color(0xFFE1BC7A);
  static const soft = Color(0xFFB9A27C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _header()),
              SliverToBoxAdapter(child: _hero()),
              SliverToBoxAdapter(child: _quickActions()),
              SliverToBoxAdapter(child: _messageCard(context)),
              SliverToBoxAdapter(child: _sectionTitle('أحدث الحكايات')),
              SliverToBoxAdapter(child: _stories()),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
      child: Row(
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
              letterSpacing: 1,
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
    );
  }

  Widget _hero() {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF30291F)),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF20201D),
            Color(0xFF0D0E11),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20,
            top: -35,
            child: Icon(
              Icons.nightlight_round,
              size: 145,
              color: gold.withOpacity(.10),
            ),
          ),
          Positioned(
            right: 24,
            top: 28,
            child: Text(
              'حكاية اليوم',
              style: TextStyle(
                color: gold.withOpacity(.85),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Positioned(
            right: 24,
            top: 65,
            left: 24,
            child: Text(
              'قصر لا ينام',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Positioned(
            right: 24,
            top: 112,
            left: 24,
            child: Text(
              'بين الرمال والظلال، لا كل القصور مهجورة.. بعضها ينتظر من يعود.',
              style: TextStyle(
                color: Color(0xFFBDB9B0),
                fontSize: 14,
                height: 1.7,
              ),
            ),
          ),
          Positioned(
            right: 24,
            bottom: 24,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: const Text('اقرأ الآن'),
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                foregroundColor: const Color(0xFF17130D),
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActions() {
    final items = [
      (Icons.map_outlined, 'الخريطة', 'اكتشف أماكن جديدة'),
      (Icons.theater_comedy_outlined, 'الشخصيات', 'تعرف على رموز الدجى'),
      (Icons.auto_awesome_outlined, 'إنجازاتك', '3 من 12'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Container(
              height: 112,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: panel,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF292A2F)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.$1, color: gold, size: 27),
                  const SizedBox(height: 9),
                  Text(
                    item.$2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.$3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF77777D),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _messageCard(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 10, 18, 22),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF292A2F)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gold.withOpacity(.12),
              ),
              child: const Icon(
                Icons.mail_outline_rounded,
                color: gold,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'لديك رسالة جديدة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'وصلك رسالة مجهولة',
                    style: TextStyle(color: Color(0xFF77777D)),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              radius: 20,
              backgroundColor: gold,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF17130D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Text(
        title,
        style: const TextStyle(
          color: gold,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _stories() {
    final stories = [
      ('مدينة تحت الرمال', Icons.landscape_outlined, 'حقيقية'),
      ('الظل الذي عاد', Icons.architecture_outlined, 'تراثية'),
    ];

    return SizedBox(
      height: 185,
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: stories.length,
        itemBuilder: (_, i) {
          return Container(
            width: 220,
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF292A2F)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF27251F),
                            Color(0xFF0D0E11),
                          ],
                        ),
                      ),
                      child: Icon(
                        stories[i].$2,
                        size: 75,
                        color: gold.withOpacity(.18),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      stories[i].$3,
                      style: const TextStyle(
                        color: Color(0xFFE2D5BA),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  bottom: 14,
                  child: Text(
                    stories[i].$1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
