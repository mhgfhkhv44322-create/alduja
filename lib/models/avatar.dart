class Avatar {
  final String id;
  final String name;
  final String? imageUrl;
  final bool isRare;

  const Avatar({
    required this.id,
    required this.name,
    this.imageUrl,
    this.isRare = false,
  });

  factory Avatar.fromMap(Map<String, dynamic> map) {
    return Avatar(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      imageUrl: map['image_url']?.toString(),
      isRare: map['is_rare'] == true,
    );
  }
}
