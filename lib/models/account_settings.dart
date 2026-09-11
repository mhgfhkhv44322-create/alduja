class AccountSettings {
  final String userId;
  final bool anonymousMessages;
  final bool showTitle;
  final bool notifications;

  const AccountSettings({
    required this.userId,
    this.anonymousMessages = true,
    this.showTitle = true,
    this.notifications = true,
  });

  factory AccountSettings.fromMap(Map<String, dynamic> map) {
    return AccountSettings(
      userId: map['user_id']?.toString() ?? '',
      anonymousMessages: map['anonymous_messages'] != false,
      showTitle: map['show_title'] != false,
      notifications: map['notifications'] != false,
    );
  }
}
