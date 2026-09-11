class SendMessage {
  final String receiverId;
  final String text;

  const SendMessage({
    required this.receiverId,
    required this.text,
  });

  Map<String, dynamic> toMap(String senderId) {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message_text': text.trim(),
    };
  }
}
