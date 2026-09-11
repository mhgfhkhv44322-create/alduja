import 'package:flutter/material.dart';
import '../models/story.dart';
import '../services/story_service.dart';
import 'discoveries_screen.dart';
import 'story_detail_screen.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  late Future<List<Story>> storiesFuture;

  @override
  void initState() {
    super.initState();
    storiesFuture = StoryService().getStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحكايات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.explore_outlined),
            tooltip: 'اكتشافاتي',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DiscoveriesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Story>>(
        future: storiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ: ${snapshot.error}'),
            );
          }

          final stories = snapshot.data ?? [];

          if (stories.isEmpty) {
            return const Center(
              child: Text('ماكو حكايات بعد...'),
            );
          }

          return RefreshIndicator(onRefresh: () async { setState(() { storiesFuture = StoryService().getStories(); }); await storiesFuture; }, child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.auto_stories_outlined),
                  title: Text(story.title),
                  subtitle: Text(
                    story.cityName ?? 'حكاية من الدجى',
                  ),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoryDetailScreen(story: story),
                      ),
                    );
                  },
                ),
              );
            },
          ));
        },
      ),
    );
  }
}
