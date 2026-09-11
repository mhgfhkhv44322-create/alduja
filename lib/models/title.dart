class UserTitle {
  final String id;
  final String name;
  final String? description;

  const UserTitle({
    required this.id,
    required this.name,
    this.description,
  });

  factory UserTitle.fromMap(Map<String, dynamic> map) {
    return UserTitle(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString(),
    );
  }
}
