class UserAchievement {
  final String id;
  final String userId;
  final String achievementId;
  final DateTime? unlockedAt;

  const UserAchievement({
    required this.id,
    required this.userId,
    required this.achievementId,
    this.unlockedAt,
  });

  factory UserAchievement.fromMap(Map<String, dynamic> map) {
    return UserAchievement(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      achievementId: map['achievement_id']?.toString() ?? '',
      unlockedAt: map['unlocked_at'] != null
          ? DateTime.tryParse(map['unlocked_at'].toString())
          : null,
    );
  }
}
