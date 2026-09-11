import 'package:flutter/material.dart';
import '../models/city.dart';
import '../models/story.dart';
import '../models/village.dart';
import '../services/city_discovery_service.dart';
import '../services/city_story_service.dart';
import '../services/village_service.dart';
import 'story_detail_screen.dart';
import 'village_screen.dart';
import 'city_chat_screen.dart';

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
    final description =
        widget.city.description ?? 'مدينة لم تكشف كل أسرارها بعد.';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.location_city_outlined,
              size: 70,
            ),
            const SizedBox(height: 20),
            Text(
              widget.city.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                height: 1.8,
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
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
              label: const Text('شات المدينة'),
            ),

            const SizedBox(height: 28),

            const Text(
              'قرى المدينة',
              style: TextStyle(
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
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'تعذر تحميل قرى المدينة.',
                  );
                }

                final villages = snapshot.data ?? [];

                if (villages.isEmpty) {
                  return const Text(
                    'ماكو قرى مكتشفة هنا بعد.',
                  );
                }

                return Column(
                  children: villages.map((village) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.holiday_village_outlined,
                        ),
                        title: Text(village.name),
                        subtitle: Text(
                          village.description ??
                              'قرية من أطراف المدينة',
                        ),
                        trailing: const Icon(
                          Icons.chevron_left,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  VillageScreen(
                                village: village,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 28),

            const Text(
              'حكايات هذه المدينة',
              style: TextStyle(
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
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'تعذر تحميل حكايات المدينة.',
                  );
                }

                final stories = snapshot.data ?? [];

                if (stories.isEmpty) {
                  return const Text(
                    'بعد ما انكشفت حكايات هذه المدينة.',
                  );
                }

                return Column(
                  children: stories.map((story) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.auto_stories_outlined,
                      ),
                      title: Text(story.title),
                      trailing: const Icon(
                        Icons.chevron_left,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                StoryDetailScreen(
                              story: story,
                            ),
                          ),
                        );
                      },
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
