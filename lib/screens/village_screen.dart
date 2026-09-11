import 'package:flutter/material.dart';
import '../models/village.dart';
import '../models/village_dialogue.dart';
import '../services/village_dialogue_service.dart';

class VillageScreen extends StatefulWidget {
  final Village village;

  const VillageScreen({
    super.key,
    required this.village,
  });

  @override
  State<VillageScreen> createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {
  late Future<List<VillageDialogue>> dialoguesFuture;

  @override
  void initState() {
    super.initState();
    dialoguesFuture =
        VillageDialogueService().getDialogues(widget.village.id);
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.village.description ??
        'قرية هادئة عند أطراف الطريق، لا يعرف الغريب منها إلا ما يراه بعينيه.';

    return Scaffold(
      backgroundColor: const Color(0xFF050912),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050912),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.village.name,
          style: const TextStyle(
            color: Color(0xFFE3C477),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1C2A3D),
                    Color(0xFF0B111B),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFE3C477).withOpacity(.15),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 28,
                    left: 28,
                    child: Icon(
                      Icons.nightlight_round,
                      size: 45,
                      color: const Color(0xFFE3C477).withOpacity(.72),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.village.name,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'قرية عند أطراف إرم',
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
              'المكان',
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

            const SizedBox(height: 28),

            _SectionCard(
              icon: Icons.water_drop_outlined,
              title: 'البئر القديم',
              subtitle: 'مكان قديم في القرية... ما تعرف عنه كلشي بعد.',
              onTap: () {
                _showDiscovery(
                  context,
                  'البئر القديم',
                  'المكان هادئ أكثر مما ينبغي. بعض الأشياء لا تظهر لمن ينظر إليها بسرعة.',
                );
              },
            ),

            const SizedBox(height: 12),

            _SectionCard(
              icon: Icons.route_outlined,
              title: 'طريق القوافل',
              subtitle: 'الطريق الذي يمر من أطراف رملة.',
              onTap: () {
                _showDiscovery(
                  context,
                  'طريق القوافل',
                  'آثار العجلات والدواب تختفي تدريجيًا في الرمل. يبدو أن الطريق شهد أكثر من قافلة واحدة.',
                );
              },
            ),

            const SizedBox(height: 12),

            _SectionCard(
              icon: Icons.nightlight_outlined,
              title: 'ما بعد القرية',
              subtitle: 'جهة لا يكثر الناس من الحديث عنها.',
              onTap: () {
                _showDiscovery(
                  context,
                  'ما بعد القرية',
                  'الطريق هناك غير واضح، وبعض آثاره أقدم من القرية نفسها.',
                );
              },
            ),

            const SizedBox(height: 32),

            const Text(
              'أصوات من رملة',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'مو كل صوت يحمل الحقيقة.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 14),

            FutureBuilder<List<VillageDialogue>>(
              future: dialoguesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'تعذر الوصول إلى الأصوات الآن.',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white38),
                  );
                }

                final dialogues = snapshot.data ?? [];

                if (dialogues.isEmpty) {
                  return const _EmptyDialogue();
                }

                return Column(
                  children: dialogues.map((dialogue) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _DialogueCard(dialogue: dialogue),
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

  void _showDiscovery(
    BuildContext context,
    String title,
    String text,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B111B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 45,
                height: 4,
                margin: const EdgeInsets.only(bottom: 22),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Text(
                title,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFFE3C477),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                text,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.9,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SectionCard({
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
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1420),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFE3C477).withOpacity(.1),
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
              Expanded(
                child: Column(
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
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Icon(
                icon,
                color: const Color(0xFFE3C477),
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogueCard extends StatelessWidget {
  final VillageDialogue dialogue;

  const _DialogueCard({
    required this.dialogue,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: const Color(0xFF0D1420),
      backgroundColor: const Color(0xFF101927),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      iconColor: const Color(0xFFE3C477),
      collapsedIconColor: Colors.white38,
      title: Text(
        dialogue.speakerName,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          child: Text(
            dialogue.dialogue,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white70,
              height: 1.8,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyDialogue extends StatelessWidget {
  const _EmptyDialogue();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1019),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: const Text(
        'القرية هادئة الليلة...\nماكو صوت مكتشف بعد.',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white38,
          height: 1.8,
        ),
      ),
    );
  }
}
