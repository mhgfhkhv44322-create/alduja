class UserCity {
  final String id;
  final String userId;
  final String cityId;
  final String? discoveredFromStoryId;
  final DateTime? discoveredAt;

  const UserCity({
    required this.id,
    required this.userId,
    required this.cityId,
    this.discoveredFromStoryId,
    this.discoveredAt,
  });

  factory UserCity.fromMap(Map<String, dynamic> map) {
    return UserCity(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      cityId: map['city_id']?.toString() ?? '',
      discoveredFromStoryId:
          map['discovered_from_story_id']?.toString(),
      discoveredAt: map['discovered_at'] != null
          ? DateTime.tryParse(map['discovered_at'].toString())
          : null,
    );
  }
}
