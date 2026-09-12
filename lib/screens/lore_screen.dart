import 'package:flutter/material.dart';
import '../models/lore_knowledge.dart';
import '../services/lore_service.dart';

class LoreScreen extends StatefulWidget {
  const LoreScreen({super.key});

  @override
  State<LoreScreen> createState() => _LoreScreenState();
}

class _LoreScreenState extends State<LoreScreen> {
  final LoreService _service = LoreService();
  late Future<List<LoreKnowledge>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getPublicLore();
  }

  String _typeTitle(String type) {
    switch (type) {
      case 'event':
        return 'حدث';
      case 'rumor':
        return 'إشاعة';
      case 'clue':
        return 'أثر';
      case 'mystery':
      case 'world_mystery':
        return 'لغز';
      case 'village':
        return 'رملة';
      case 'world':
        return 'من العالم';
      default:
        return 'أصداء';
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'event':
        return Icons.history_rounded;
      case 'rumor':
        return Icons.forum_outlined;
      case 'clue':
        return Icons.search_rounded;
      case 'mystery':
      case 'world_mystery':
        return Icons.nights_stay_outlined;
      case 'village':
        return Icons.home_work_outlined;
      default:
        return Icons.auto_awesome_outlined;
    }
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
          'أصداء العالم',
          style: TextStyle(
            color: Color(0xFFE5C77A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<LoreKnowledge>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE5C77A),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'تعذر تحميل أصداء العالم حالياً.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .75),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          final lore = snapshot.data ?? [];

          if (lore.isEmpty) {
            return Center(
              child: Text(
                'لا توجد أصداء مكتشفة بعد...',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .65),
                  fontSize: 16,
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: const Color(0xFFE5C77A),
            backgroundColor: const Color(0xFF101724),
            onRefresh: () async {
              setState(() {
                _future = _service.getPublicLore();
              });
              await _future;
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              itemCount: lore.length,
              itemBuilder: (context, index) {
                final item = lore[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101724),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE5C77A).withValues(alpha: .16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .18),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            _typeIcon(item.knowledgeType),
                            color: const Color(0xFFE5C77A),
                            size: 21,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _typeTitle(item.knowledgeType),
                            style: const TextStyle(
                              color: Color(0xFFE5C77A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'أثر ${item.difficulty}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: .38),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        item.knowledgeText,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .88),
                          height: 1.75,
                          fontSize: 15,
                        ),
                      ),
                      if (item.sourceName != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          '— ${item.sourceName}',
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .35),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
