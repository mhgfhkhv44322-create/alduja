import 'package:flutter/material.dart';
import '../services/discovery_service.dart';

class DiscoveriesScreen extends StatefulWidget {
  const DiscoveriesScreen({super.key});

  @override
  State<DiscoveriesScreen> createState() => _DiscoveriesScreenState();
}

class _DiscoveriesScreenState extends State<DiscoveriesScreen> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
    future = DiscoveryService().getDiscoveries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اكتشافاتي'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ: ${snapshot.error}'),
            );
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Text('بعدك ما اكتشفت شي...'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final key = items[index]['discovery_key']
                      ?.toString() ??
                  '';

              final isStory = key.startsWith('story_');

              return Card(
                child: ListTile(
                  leading: Icon(
                    isStory
                        ? Icons.auto_stories_outlined
                        : Icons.explore_outlined,
                  ),
                  title: Text(
                    isStory ? 'حكاية مكتشفة' : 'اكتشاف جديد',
                  ),
                  subtitle: Text(key),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
