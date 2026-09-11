import 'package:flutter/material.dart';
import 'cities_screen.dart';
import 'lore_screen.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen({super.key});

  static const gold = Color(0xFFE3C477);
  static const bg = Color(0xFF050912);
  static const panel = Color(0xFF0D1420);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF101827),
                    bg,
                    const Color(0xFF03060C),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: -90,
            right: -50,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gold.withOpacity(.055),
              ),
            ),
          ),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 40),
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoreScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.auto_awesome_outlined,
                        color: gold,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الدجى',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: gold,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'العالم',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: gold.withOpacity(.16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF182337),
                        panel,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 28,
                        left: 30,
                        child: Icon(
                          Icons.nightlight_round,
                          size: 48,
                          color: gold.withOpacity(.8),
                        ),
                      ),
                      Positioned(
                        bottom: 34,
                        left: 24,
                        right: 24,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black.withOpacity(.18),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 55,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                                color: Colors.black.withOpacity(.28),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 90,
                              height: 72,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(45),
                                ),
                                color: Colors.black.withOpacity(.32),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        right: 22,
                        bottom: 22,
                        child: Text(
                          'أماكن لم تُكتشف بعد',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'العالم لا يكشف نفسه دفعة واحدة.',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'كل طريق يقود إلى حكاية، وبعض الحكايات لا تبدأ إلا بعد أن تبحث عنها.',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.48),
                    height: 1.7,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 22),

                _WorldButton(
                  icon: Icons.location_city_outlined,
                  title: 'المدن',
                  subtitle: 'اكتشف الأماكن التي ظهرت لك',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CitiesScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                _WorldButton(
                  icon: Icons.auto_awesome_outlined,
                  title: 'أصداء العالم',
                  subtitle: 'آثار وحكايات ظهرت من رحلتك',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoreScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorldButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _WorldButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1420),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFE3C477).withOpacity(.12),
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white38,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE3C477).withOpacity(.08),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFE3C477),
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
