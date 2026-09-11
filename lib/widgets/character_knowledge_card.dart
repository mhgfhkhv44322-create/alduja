import 'package:flutter/material.dart';

class CharacterKnowledgeCard extends StatelessWidget {
  final String knowledgeType;
  final String knowledgeText;
  final String revealStyle;

  const CharacterKnowledgeCard({
    super.key,
    required this.knowledgeType,
    required this.knowledgeText,
    required this.revealStyle,
  });

  String get _label {
    switch (knowledgeType) {
      case 'rumor':
        return 'إشاعة';
      case 'mystery':
        return 'لغز';
      case 'caravan':
        return 'أثر قافلة';
      case 'record':
        return 'سجل قديم';
      case 'well':
        return 'أثر البئر';
      default:
        return 'أثر من الحكاية';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              knowledgeText,
              style: const TextStyle(
                fontSize: 16,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
