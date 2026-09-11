class InboxMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String messageText;
  final bool isRead;
  final DateTime createdAt;

  const InboxMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.messageText,
    required this.isRead,
    required this.createdAt,
  });

  factory InboxMessage.fromMap(Map<String, dynamic> map) {
    return InboxMessage(
      id: map['id'].toString(),
      senderId: map['sender_id'].toString(),
      receiverId: map['receiver_id'].toString(),
      messageText: map['message_text'].toString(),
      isRead: map['is_read'] == true,
      createdAt: DateTime.parse(
        map['created_at'].toString(),
      ),
    );
  }
}
