class ReplyMessageResult {
  final bool success;
  final String? message;

  const ReplyMessageResult({
    required this.success,
    this.message,
  });

  factory ReplyMessageResult.success() {
    return const ReplyMessageResult(
      success: true,
      message: 'تم إرسال الرد',
    );
  }

  factory ReplyMessageResult.failure(String message) {
    return ReplyMessageResult(
      success: false,
      message: message,
    );
  }
}
