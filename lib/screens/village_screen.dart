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
    final description =
        widget.village.description ?? 'قرية قديمة لم تكشف كل أسرارها بعد.';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.village.name),
      ),
      body: FutureBuilder<List<VillageDialogue>>(
        future: dialoguesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final dialogues = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Icon(
                Icons.holiday_village_outlined,
                size: 70,
              ),
              const SizedBox(height: 20),
              Text(
                widget.village.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'أحاديث أهل القرية',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (dialogues.isEmpty)
                const Text(
                  'القرية هادئة الليلة... ماكو حوار مكتشف بعد.',
                )
              else
                ...dialogues.map(
                  (dialogue) => Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            dialogue.speakerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dialogue.dialogue,
                            style: const TextStyle(
                              fontSize: 17,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
