class UserSearchFilter {
  final String? name;
  final String? title;
  final String? userId;
  final String? city;

  const UserSearchFilter({
    this.name,
    this.title,
    this.userId,
    this.city,
  });

  bool get isEmpty =>
      (name == null || name!.trim().isEmpty) &&
      (title == null || title!.trim().isEmpty) &&
      (userId == null || userId!.trim().isEmpty) &&
      (city == null || city!.trim().isEmpty);
}
