class Discovery {
  final String id;
  final String userId;
  final String discoveryKey;
  final DateTime? discoveredAt;

  const Discovery({
    required this.id,
    required this.userId,
    required this.discoveryKey,
    this.discoveredAt,
  });

  factory Discovery.fromMap(Map<String, dynamic> map) {
    return Discovery(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      discoveryKey: map['discovery_key']?.toString() ?? '',
      discoveredAt: map['discovered_at'] != null
          ? DateTime.tryParse(map['discovered_at'].toString())
          : null,
    );
  }
}
