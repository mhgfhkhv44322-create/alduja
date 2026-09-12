import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'saden_chat_screen.dart';

class MajalisScreen extends StatefulWidget {
  const MajalisScreen({super.key});

  @override
  State<MajalisScreen> createState() => _MajalisScreenState();
}

class _MajalisScreenState extends State<MajalisScreen> {
  final _supabase = Supabase.instance.client;

  List<Map<String, dynamic>> _characters = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final data = await _supabase
          .from('characters')
          .select('id, name, title, description, image_url')
          .order('created_at');

      if (!mounted) return;

      setState(() {
        _characters = (data as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  void _openCharacter(Map<String, dynamic> character) {
    final id = character['id']?.toString();

    if (id == null || id.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SadenChatScreen(
          characterId: id,
          characterName:
              character['name']?.toString() ?? 'شخصية من الدجى',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF070B14),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'مجالس الدجى',
          style: TextStyle(
            color: Color(0xFFE8D39A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE8D39A),
              ),
            )
          : _characters.isEmpty
              ? const Center(
                  child: Text(
                    'لم تُفتح مجالس الدجى بعد.',
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadCharacters,
                  color: const Color(0xFFE8D39A),
                  backgroundColor: const Color(0xFF121925),
                  child: ListView(
                    padding: const EdgeInsets.all(18),
                    children: [
                      const Text(
                        'لكل شخص في الدجى حكاية لا تُقال بسهولة.',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 22),
                      ..._characters.map(_characterCard),
                    ],
                  ),
                ),
    );
  }

  Widget _characterCard(Map<String, dynamic> character) {
    final name = character['name']?.toString() ?? 'مجهول';
    final title = character['title']?.toString() ?? '';
    final description = character['description']?.toString() ?? '';
    final imageUrl = character['image_url']?.toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1420),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE8D39A).withValues(alpha: .14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => _openCharacter(character),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 72,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF181E2A),
                  image: imageUrl != null && imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageUrl == null || imageUrl.isEmpty
                    ? const Icon(
                        Icons.person_outline,
                        color: Color(0xFFE8D39A),
                        size: 34,
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (title.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        title,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Color(0xFFE8D39A),
                          fontSize: 12,
                        ),
                      ),
                    ],
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'ادخل المجلس',
                          style: TextStyle(
                            color: Color(0xFFE8D39A),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 12,
                          color: Color(0xFFE8D39A),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
