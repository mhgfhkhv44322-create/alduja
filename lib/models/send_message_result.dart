class SendMessageResult {
  final bool success;
  final String? messageId;
  final String? error;

  const SendMessageResult({
    required this.success,
    this.messageId,
    this.error,
  });

  factory SendMessageResult.success(String messageId) {
    return SendMessageResult(
      success: true,
      messageId: messageId,
    );
  }

  factory SendMessageResult.failure(String error) {
    return SendMessageResult(
      success: false,
      error: error,
    );
  }
}
