class Achievement {
  final String id;
  final String name;
  final String? description;
  final bool isSecret;

  const Achievement({
    required this.id,
    required this.name,
    this.description,
    this.isSecret = false,
  });

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString(),
      isSecret: map['is_secret'] == true,
    );
  }
}
