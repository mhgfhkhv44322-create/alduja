class UserSearchResult {
  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String? title;

  const UserSearchResult({
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.title,
  });
}
