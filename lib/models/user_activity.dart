class UserActivity {
  final String userId;
  final int messageCount;
  final int interactionCount;
  final DateTime? lastActivityAt;

  const UserActivity({
    required this.userId,
    this.messageCount = 0,
    this.interactionCount = 0,
    this.lastActivityAt,
  });

  int get score {
    final recentActivity = lastActivityAt == null ? 0 : 1;
    return messageCount + interactionCount + recentActivity;
  }
}
