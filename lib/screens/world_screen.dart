import 'package:flutter/material.dart';
import 'cities_screen.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen({super.key});

  static const gold = Color(0xFFE3C477);
  static const background = Color(0xFF050912);
  static const panel = Color(0xFF0D1420);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF111B2B),
                    Color(0xFF070D17),
                    Color(0xFF03060C),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -90,
            right: -70,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gold.withValues(alpha: .06),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الدجى',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: gold,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'العالم',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: panel,
                    border: Border.all(
                      color: gold.withValues(alpha: .14),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 25,
                        left: 25,
                        child: Icon(
                          Icons.nightlight_round,
                          size: 52,
                          color: gold.withValues(alpha: .8),
                        ),
                      ),
                      Positioned(
                        left: 25,
                        right: 25,
                        bottom: 28,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 55,
                              height: 82,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .3),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 75,
                              height: 115,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .35),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: .25),
                                  borderRadius: BorderRadius.circular(40),
                                ),
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
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
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
                const SizedBox(height: 8),
                const Text(
                  'كل طريق يقود إلى حكاية، وبعض الأماكن لا تظهر إلا لمن يبحث عنها.',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white54,
                    height: 1.7,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(23),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CitiesScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: panel,
                        borderRadius: BorderRadius.circular(23),
                        border: Border.all(
                          color: gold.withValues(alpha: .13),
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'المدن',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'اكتشف الأماكن التي ظهرت لك',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: gold.withValues(alpha: .08),
                            ),
                            child: const Icon(
                              Icons.location_city_outlined,
                              color: gold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
