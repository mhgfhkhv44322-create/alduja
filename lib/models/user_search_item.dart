class UserSearchItem {
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String? title;
  final String? city;

  const UserSearchItem({
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.title,
    this.city,
  });

  factory UserSearchItem.fromMap(Map<String, dynamic> map) {
    return UserSearchItem(
      userId: map['id'] as String,
      username: map['username'] as String,
      displayName: map['display_name'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      title: map['title'] as String?,
      city: map['city'] as String?,
    );
  }
}
