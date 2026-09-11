class UserSettings {
  final String userId;
  final bool anonymousMessages;
  final bool showTitle;
  final bool notifications;

  const UserSettings({
    required this.userId,
    this.anonymousMessages = true,
    this.showTitle = true,
    this.notifications = true,
  });

  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      userId: map['user_id']?.toString() ?? '',
      anonymousMessages: map['anonymous_messages'] != false,
      showTitle: map['show_title'] != false,
      notifications: map['notifications'] != false,
    );
  }
}
