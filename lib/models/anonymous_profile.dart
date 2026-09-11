class AnonymousProfile {
  final String id;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final String? title;

  const AnonymousProfile({
    required this.id,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.bio,
    this.title,
  });

  factory AnonymousProfile.fromMap(Map<String, dynamic> map) {
    return AnonymousProfile(
      id: map['id']?.toString() ?? '',
      username: map['username']?.toString() ?? '',
      displayName: map['display_name']?.toString(),
      avatarUrl: map['avatar_url']?.toString(),
      bio: map['bio']?.toString(),
      title: map['title']?.toString(),
    );
  }
}
