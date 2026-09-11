class Character {
  final String id;
  final String name;
  final String? title;
  final String? description;
  final String? imageUrl;

  const Character({
    required this.id,
    required this.name,
    this.title,
    this.description,
    this.imageUrl,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'].toString(),
      name: map['name']?.toString() ?? 'شخصية مجهولة',
      title: map['title']?.toString(),
      description: map['description']?.toString(),
      imageUrl: map['image_url']?.toString(),
    );
  }
}
