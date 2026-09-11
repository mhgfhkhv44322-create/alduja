class Report {
  final String reportedUserId;
  final String reason;
  final DateTime? createdAt;

  const Report({
    required this.reportedUserId,
    required this.reason,
    this.createdAt,
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      reportedUserId:
          map['reported_user_id']?.toString() ?? '',
      reason: map['reason']?.toString() ?? '',
      createdAt: map['created_at'] == null
          ? null
          : DateTime.tryParse(
              map['created_at'].toString(),
            ),
    );
  }
}
