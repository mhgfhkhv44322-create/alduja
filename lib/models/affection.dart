class CharacterAffection {
  final String id;
  final String userId;
  final String characterId;
  final int affection;
  final DateTime? updatedAt;

  const CharacterAffection({
    required this.id,
    required this.userId,
    required this.characterId,
    required this.affection,
    this.updatedAt,
  });

  factory CharacterAffection.fromMap(Map<String, dynamic> map) {
    return CharacterAffection(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      characterId: map['character_id']?.toString() ?? '',
      affection: (map['affection'] as num?)?.toInt() ?? 0,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'].toString())
          : null,
    );
  }
}
