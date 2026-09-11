class Conversation {
  final String userId;
  final String? username;
  final String? displayName;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;

  const Conversation({
    required this.userId,
    this.username,
    this.displayName,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
  });

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      userId: map['user_id']?.toString() ?? '',
      username: map['username']?.toString(),
      displayName: map['display_name']?.toString(),
      lastMessage: map['last_message']?.toString(),
      lastMessageAt: map['last_message_at'] == null
          ? null
          : DateTime.tryParse(
              map['last_message_at'].toString(),
            ),
      unreadCount:
          int.tryParse(
                map['unread_count']?.toString() ?? '0',
              ) ??
              0,
    );
  }
}
