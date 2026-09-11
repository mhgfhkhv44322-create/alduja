class ModerationAction {
  final String type;
  final String targetId;
  final String? reason;
  final DateTime? createdAt;

  const ModerationAction({
    required this.type,
    required this.targetId,
    this.reason,
    this.createdAt,
  });
}
