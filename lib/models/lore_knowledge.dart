class LoreKnowledge {
  final String id;
  final String? storyId;
  final String? cityId;
  final String? villageId;
  final String knowledgeType;
  final String knowledgeText;
  final String? sourceName;
  final int difficulty;
  final bool isPublic;
  final DateTime? createdAt;

  const LoreKnowledge({
    required this.id,
    this.storyId,
    this.cityId,
    this.villageId,
    required this.knowledgeType,
    required this.knowledgeText,
    this.sourceName,
    required this.difficulty,
    required this.isPublic,
    this.createdAt,
  });

  factory LoreKnowledge.fromMap(Map<String, dynamic> map) {
    return LoreKnowledge(
      id: map['id'] as String,
      storyId: map['story_id'] as String?,
      cityId: map['city_id'] as String?,
      villageId: map['village_id'] as String?,
      knowledgeType: map['knowledge_type'] as String,
      knowledgeText: map['knowledge_text'] as String,
      sourceName: map['source_name'] as String?,
      difficulty: (map['difficulty'] as num?)?.toInt() ?? 1,
      isPublic: map['is_public'] as bool? ?? false,
      createdAt: map['created_at'] == null
          ? null
          : DateTime.parse(map['created_at'] as String),
    );
  }
}
