class UserBlock {
  final String id;
  final String blockerId;
  final String blockedId;
  final DateTime? createdAt;

  const UserBlock({
    required this.id,
    required this.blockerId,
    required this.blockedId,
    this.createdAt,
  });

  factory UserBlock.fromMap(Map<String, dynamic> map) {
    return UserBlock(
      id: map['id']?.toString() ?? '',
      blockerId: map['blocker_id']?.toString() ?? '',
      blockedId: map['blocked_id']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }
}
