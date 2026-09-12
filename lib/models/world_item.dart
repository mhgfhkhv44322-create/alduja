class WorldItem {
  final String id;
  final String itemKey;
  final String name;
  final String itemType;
  final String rarity;
  final String? description;
  final Map<String, dynamic> effects;
  final Map<String, dynamic> requirements;
  final String? loreText;
  final bool isMagical;
  final bool isTradeable;

  const WorldItem({
    required this.id,
    required this.itemKey,
    required this.name,
    required this.itemType,
    required this.rarity,
    this.description,
    this.effects = const {},
    this.requirements = const {},
    this.loreText,
    this.isMagical = false,
    this.isTradeable = true,
  });

  factory WorldItem.fromMap(Map<String, dynamic> map) {
    return WorldItem(
      id: map['id']?.toString() ?? '',
      itemKey: map['item_key']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      itemType: map['item_type']?.toString() ?? 'misc',
      rarity: map['rarity']?.toString() ?? 'common',
      description: map['description']?.toString(),
      effects: Map<String, dynamic>.from(map['effects'] ?? {}),
      requirements:
          Map<String, dynamic>.from(map['requirements'] ?? {}),
      loreText: map['lore_text']?.toString(),
      isMagical: map['is_magical'] == true,
      isTradeable: map['is_tradeable'] != false,
    );
  }
}
