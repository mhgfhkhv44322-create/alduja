class CityMessage {
  final String id;
  final String cityId;
  final String userId;
  final String messageText;
  final DateTime? createdAt;

  const CityMessage({
    required this.id,
    required this.cityId,
    required this.userId,
    required this.messageText,
    this.createdAt,
  });

  factory CityMessage.fromMap(Map<String, dynamic> map) {
    return CityMessage(
      id: map['id']?.toString() ?? '',
      cityId: map['city_id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      messageText: map['message_text']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }
}
