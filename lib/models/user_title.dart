class UserTitle {
  final String userId;
  final String titleId;
  final DateTime? unlockedAt;

  const UserTitle({
    required this.userId,
    required this.titleId,
    this.unlockedAt,
  });

  factory UserTitle.fromMap(Map<String, dynamic> map) {
    return UserTitle(
      userId: map['user_id']?.toString() ?? '',
      titleId: map['title_id']?.toString() ?? '',
      unlockedAt: map['unlocked_at'] != null
          ? DateTime.tryParse(map['unlocked_at'].toString())
          : null,
    );
  }
}
