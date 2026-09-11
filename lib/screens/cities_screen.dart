import 'package:flutter/material.dart';
import 'city_detail_screen.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050912),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050912),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المدن',
          style: TextStyle(
            color: Color(0xFFE3C477),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SizedBox(height: 8),
          _CityCard(
            name: 'إرم',
            icon: Icons.location_city_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CityDetailScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          _HiddenCard(
            title: 'مكان غير معروف',
            subtitle: 'لم يُكشف موقعه بعد',
          ),
        ],
      ),
    );
  }
}

class _CityCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const _CityCard({
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          height: 230,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF182337),
                Color(0xFF0C131F),
              ],
            ),
            border: Border.all(
              color: const Color(0xFFE3C477).withOpacity(.18),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: const Color(0xFFE3C477).withOpacity(.75),
                size: 30,
              ),
              const SizedBox(height: 12),
              Text(
                name,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'ادخل واكتشف ما تخفيه',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HiddenCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HiddenCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A101A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            color: Colors.white24,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.white24,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
