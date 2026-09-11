class CharacterUnlock {
  final String userId;
  final String characterId;
  final DateTime? unlockedAt;

  const CharacterUnlock({
    required this.userId,
    required this.characterId,
    this.unlockedAt,
  });

  factory CharacterUnlock.fromMap(Map<String, dynamic> map) {
    return CharacterUnlock(
      userId: map['user_id']?.toString() ?? '',
      characterId: map['character_id']?.toString() ?? '',
      unlockedAt: map['unlocked_at'] != null
          ? DateTime.tryParse(map['unlocked_at'].toString())
          : null,
    );
  }
}
