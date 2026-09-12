import 'package:flutter/material.dart';
import '../widgets/blacksmith_place_card.dart';
import '../models/city.dart';
import '../models/story.dart';
import '../models/village.dart';
import '../services/city_discovery_service.dart';
import '../services/city_story_service.dart';
import '../services/village_service.dart';
import 'city_chat_screen.dart';
import 'story_detail_screen.dart';
import 'village_screen.dart';

class CityDetailScreen extends StatefulWidget {
  final City city;

  const CityDetailScreen({
    super.key,
    required this.city,
  });

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  late Future<List<Story>> storiesFuture;
  late Future<List<Village>> villagesFuture;

  @override
  void initState() {
    super.initState();

    CityDiscoveryService().discoverCity(widget.city.id);

    storiesFuture =
        CityStoryService().getStoriesForCity(widget.city.id);

    villagesFuture =
        VillageService().getVillagesForCity(widget.city.id);
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.city.description ??
        'مدينة قديمة لا تكشف أسرارها للغريب من النظرة الأولى.';

    return Scaffold(
      backgroundColor: const Color(0xFF050912),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050912),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.city.name,
          style: const TextStyle(
            color: Color(0xFFE3C477),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BlacksmithPlaceCard(),
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A273B),
                    Color(0xFF0A101B),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFE3C477).withValues(alpha: .16),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 25,
                    right: 25,
                    child: Icon(
                      Icons.nightlight_round,
                      size: 42,
                      color: const Color(0xFFE3C477).withValues(alpha: .7),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    right: 22,
                    bottom: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.city.name,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'مدينة مكتشفة',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Color(0xFFE3C477),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'عن المكان',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFFE3C477),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              description,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.9,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CityChatScreen(
                        cityId: widget.city.id,
                        cityName: widget.city.name,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.forum_outlined),
                label: const Text(
                  'مجلس المدينة',
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'الأماكن القريبة',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            FutureBuilder<List<Village>>(
              future: villagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'تعذر تحميل الأماكن.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white54),
                  );
                }

                final villages = snapshot.data ?? [];

                if (villages.isEmpty) {
                  return const Text(
                    'ماكو مكان مكتشف هنا بعد.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white38),
                  );
                }

                return Column(
                  children: villages.map((village) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _PlaceCard(
                        title: village.name,
                        icon: Icons.water_outlined,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  VillageScreen(village: village),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'الحكايات المرتبطة بالمكان',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            FutureBuilder<List<Story>>(
              future: storiesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'تعذر تحميل الحكايات.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white54),
                  );
                }

                final stories = snapshot.data ?? [];

                if (stories.isEmpty) {
                  return const Text(
                    'لا توجد حكاية مكتشفة هنا بعد.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white38),
                  );
                }

                return Column(
                  children: stories.map((story) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _PlaceCard(
                        title: story.title,
                        icon: Icons.menu_book_outlined,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  StoryDetailScreen(story: story),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _PlaceCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1420),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE3C477).withValues(alpha: .1),
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
              Text(
                title,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 14),
              Icon(
                icon,
                color: const Color(0xFFE3C477),
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
