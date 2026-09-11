class Story {
  final String id;
  final String title;
  final String content;
  final String? coverUrl;
  final String? cityName;
  final DateTime? createdAt;

  const Story({
    required this.id,
    required this.title,
    required this.content,
    this.coverUrl,
    this.cityName,
    this.createdAt,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      coverUrl: map['cover_url']?.toString(),
      cityName: map['city_name']?.toString(),
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(map['created_at'].toString()),
    );
  }
}
