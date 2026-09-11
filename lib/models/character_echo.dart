class CharacterEcho {
  final String id;
  final String characterId;
  final String message;
  final String? storyId;
  final DateTime? createdAt;

  const CharacterEcho({
    required this.id,
    required this.characterId,
    required this.message,
    this.storyId,
    this.createdAt,
  });

  factory CharacterEcho.fromMap(Map<String, dynamic> map) {
    return CharacterEcho(
      id: map['id']?.toString() ?? '',
      characterId: map['character_id']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      storyId: map['story_id']?.toString(),
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }
}
