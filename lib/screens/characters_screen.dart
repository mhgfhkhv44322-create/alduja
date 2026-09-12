import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/character_service.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late Future<List<Character>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = CharacterService().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05070C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10131B),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'شخصيات الدجى',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Color(0xFFE3C477),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE3C477),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  'تعذر الوصول إلى الشخصيات الآن.',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),
              ),
            );
          }

          final characters = snapshot.data ?? [];

          if (characters.isEmpty) {
            return const Center(
              child: Text(
                'لم تُكتب أسماء الشخصيات بعد.',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(18, 24, 18, 40),
            itemCount: characters.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final character = characters[index];
              return _CharacterCard(character: character);
            },
          );
        },
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final Character character;

  const _CharacterCard({
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = character.imageUrl;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () => _showCharacter(context),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF151923),
                Color(0xFF0C0F16),
              ],
            ),
            border: Border.all(
              color: const Color(0xFFE3C477).withValues(alpha: .18),
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 120,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  color: const Color(0xFF0A0D13),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              const _CharacterSilhouette(),
                        )
                      : const _CharacterSilhouette(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        character.name,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        character.title ?? '',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Color(0xFFE3C477),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'لم تبدأ الحكاية بعد...',
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
              const Padding(
                padding: EdgeInsets.only(left: 14),
                child: Icon(
                  Icons.chevron_left,
                  color: Color(0xFFE3C477),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCharacter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF10131B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                character.name,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                character.title ?? '',
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Color(0xFFE3C477),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'بعض الحكايات لا تبدأ من أول لقاء.',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  height: 1.7,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CharacterSilhouette extends StatelessWidget {
  const _CharacterSilhouette();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.person_outline,
        color: Color(0xFFE3C477),
        size: 58,
      ),
    );
  }
}

class _CharacterPortrait extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const _CharacterPortrait({
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFC9A35B).withValues(alpha: .65),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x44C9A35B),
            blurRadius: 14,
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _silhouette(),
              )
            : _silhouette(),
      ),
    );
  }

  Widget _silhouette() {
    return Container(
      color: const Color(0xFF151923),
      alignment: Alignment.center,
      child: const Icon(
        Icons.person_outline_rounded,
        color: Color(0xFFC9A35B),
        size: 34,
      ),
    );
  }
}
