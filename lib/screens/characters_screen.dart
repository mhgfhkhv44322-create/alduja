import 'package:flutter/material.dart';
import '../services/character_service.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final CharacterService _service = CharacterService();
  late Future<List<Map<String, dynamic>>> _characters;

  @override
  void initState() {
    super.initState();
    _characters = _service.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شخصيات الدجى'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ: ${snapshot.error}'),
            );
          }

          final characters = snapshot.data ?? [];

          if (characters.isEmpty) {
            return const Center(
              child: Text('لم تُكشف الشخصيات بعد.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(
                    character['name']?.toString() ?? 'شخصية مجهولة',
                  ),
                  subtitle: Text(
                    character['title']?.toString() ??
                        'حكاية لم تُكشف تفاصيلها بعد.',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
