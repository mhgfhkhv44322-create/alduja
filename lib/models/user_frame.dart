class UserFrame {
  final String userId;
  final String frameId;

  const UserFrame({
    required this.userId,
    required this.frameId,
  });

  factory UserFrame.fromMap(Map<String, dynamic> map) {
    return UserFrame(
      userId: map['user_id']?.toString() ?? '',
      frameId: map['frame_id']?.toString() ?? '',
    );
  }
}
