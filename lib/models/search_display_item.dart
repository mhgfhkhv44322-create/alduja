class SearchDisplayItem {
  final String userId;
  final String name;
  final String? title;
  final String? avatarUrl;
  final String? city;

  const SearchDisplayItem({
    required this.userId,
    required this.name,
    this.title,
    this.avatarUrl,
    this.city,
  });

  factory SearchDisplayItem.fromMap(Map<String, dynamic> map) {
    return SearchDisplayItem(
      userId: map['id'] as String,
      name: (map['display_name'] ?? map['username'] ?? '') as String,
      title: map['title'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      city: map['city'] as String?,
    );
  }
}
