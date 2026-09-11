class DiscoveredCharacter {
  final String userId;
  final String characterId;
  final DateTime? discoveredAt;

  const DiscoveredCharacter({
    required this.userId,
    required this.characterId,
    this.discoveredAt,
  });

  factory DiscoveredCharacter.fromMap(Map<String, dynamic> map) {
    return DiscoveredCharacter(
      userId: map['user_id']?.toString() ?? '',
      characterId: map['character_id']?.toString() ?? '',
      discoveredAt: map['unlocked_at'] != null
          ? DateTime.tryParse(map['unlocked_at'].toString())
          : null,
    );
  }
}
