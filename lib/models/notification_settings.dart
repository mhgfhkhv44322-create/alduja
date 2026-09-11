class NotificationSettings {
  final bool enabled;

  const NotificationSettings({
    this.enabled = true,
  });

  factory NotificationSettings.fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      enabled: map['notifications'] != false,
    );
  }
}
