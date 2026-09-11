class UserStory {
  final String userId;
  final String storyId;
  final DateTime? readAt;

  const UserStory({
    required this.userId,
    required this.storyId,
    this.readAt,
  });

  factory UserStory.fromMap(Map<String, dynamic> map) {
    return UserStory(
      userId: map['user_id']?.toString() ?? '',
      storyId: map['story_id']?.toString() ?? '',
      readAt: map['read_at'] != null
          ? DateTime.tryParse(map['read_at'].toString())
          : null,
    );
  }
}
