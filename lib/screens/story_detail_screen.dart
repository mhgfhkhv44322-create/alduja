import 'package:flutter/material.dart';
import '../models/story.dart';
import '../services/story_read_service.dart';
import '../services/story_discovery_service.dart';
import '../services/story_city_service.dart';
import '../services/story_character_service.dart';

class StoryDetailScreen extends StatefulWidget {
  final Story story;

  const StoryDetailScreen({
    super.key,
    required this.story,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  String? linkedCity;
  List<Map<String, dynamic>> linkedCharacters = [];

  @override
  void initState() {
    super.initState();

    StoryReadService().markAsRead(widget.story.id);
    StoryDiscoveryService().discoverStory(widget.story.id);

    StoryCityService().getCityName(widget.story.id).then((value) {
      if (mounted) {
        setState(() => linkedCity = value);
      }
    });

    StoryCharacterService().getCharacters(widget.story.id).then((value) {
      if (mounted) {
        setState(() => linkedCharacters = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'حفظ الحكاية',
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.story.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (linkedCity != null || widget.story.cityName != null) ...[
              const SizedBox(height: 8),
              Text(
                linkedCity ?? widget.story.cityName!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (linkedCharacters.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'شخصيات الحكاية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...linkedCharacters.map(
                (character) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_outline),
                  ),
                  title: Text(
                    character['name']?.toString() ?? 'شخصية مجهولة',
                  ),
                  subtitle: character['title'] == null
                      ? null
                      : Text(character['title'].toString()),
                ),
              ),
            ],
            const SizedBox(height: 24),
            SelectableText(
              widget.story.content,
              style: const TextStyle(
                fontSize: 19,
                height: 2.0,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
