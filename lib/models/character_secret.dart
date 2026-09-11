class CharacterSecret {
  final String id;
  final String characterId;
  final String secretText;
  final int requiredAffection;
  final DateTime? createdAt;

  const CharacterSecret({
    required this.id,
    required this.characterId,
    required this.secretText,
    required this.requiredAffection,
    this.createdAt,
  });

  factory CharacterSecret.fromMap(Map<String, dynamic> map) {
    return CharacterSecret(
      id: map['id']?.toString() ?? '',
      characterId: map['character_id']?.toString() ?? '',
      secretText: map['secret_text']?.toString() ?? '',
      requiredAffection:
          (map['required_affection'] as num?)?.toInt() ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }
}
