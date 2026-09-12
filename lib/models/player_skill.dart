class PlayerSkill {
  final String id;
  final String skillKey;
  final String name;
  final String category;
  final String? description;
  final int requiredLevel;
  final String? requiredAttribute;
  final int requiredAttributeValue;
  final String? parentSkillId;
  final int maxRank;
  final Map<String, dynamic> effects;
  final int rank;
  final bool unlocked;

  const PlayerSkill({
    required this.id,
    required this.skillKey,
    required this.name,
    required this.category,
    this.description,
    this.requiredLevel = 1,
    this.requiredAttribute,
    this.requiredAttributeValue = 1,
    this.parentSkillId,
    this.maxRank = 1,
    this.effects = const {},
    this.rank = 0,
    this.unlocked = false,
  });

  factory PlayerSkill.fromMap(Map<String, dynamic> map) {
    return PlayerSkill(
      id: map['id']?.toString() ?? '',
      skillKey: map['skill_key']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      description: map['description']?.toString(),
      requiredLevel: map['required_level'] ?? 1,
      requiredAttribute: map['required_attribute']?.toString(),
      requiredAttributeValue: map['required_attribute_value'] ?? 1,
      parentSkillId: map['parent_skill_id']?.toString(),
      maxRank: map['max_rank'] ?? 1,
      effects: Map<String, dynamic>.from(map['effects'] ?? {}),
      rank: map['rank'] ?? 0,
      unlocked: map['unlocked'] == true || (map['rank'] ?? 0) > 0,
    );
  }
}
