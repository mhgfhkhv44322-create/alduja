class AnonymousMessage {
  final String id;
  final String receiverId;
  final String text;
  final DateTime? createdAt;
  final bool isRead;

  const AnonymousMessage({
    required this.id,
    required this.receiverId,
    required this.text,
    required this.isRead,
    this.createdAt,
  });

  factory AnonymousMessage.fromMap(Map<String, dynamic> map) {
    return AnonymousMessage(
      id: map['id']?.toString() ?? '',
      receiverId: map['receiver_id']?.toString() ?? '',
      text: map['message_text']?.toString() ?? '',
      isRead: map['is_read'] == true,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }
}
