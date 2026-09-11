class CharacterMessage {
  final String id;
  final String userId;
  final String characterId;
  final String sender;
  final String messageText;
  final DateTime? createdAt;

  const CharacterMessage({
    required this.id,
    required this.userId,
    required this.characterId,
    required this.sender,
    required this.messageText,
    this.createdAt,
  });

  factory CharacterMessage.fromMap(Map<String, dynamic> map) {
    return CharacterMessage(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      characterId: map['character_id']?.toString() ?? '',
      sender: map['sender']?.toString() ?? '',
      messageText: map['message_text']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }
}
