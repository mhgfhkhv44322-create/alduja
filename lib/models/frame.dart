class ProfileFrame {
  final String id;
  final String name;
  final String? imageUrl;
  final bool isRare;

  const ProfileFrame({
    required this.id,
    required this.name,
    this.imageUrl,
    this.isRare = false,
  });

  factory ProfileFrame.fromMap(Map<String, dynamic> map) {
    return ProfileFrame(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      imageUrl: map['image_url']?.toString(),
      isRare: map['is_rare'] == true,
    );
  }
}
