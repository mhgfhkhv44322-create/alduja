class MessageGuardResult {
  final bool allowed;
  final String text;
  final String? reason;

  const MessageGuardResult({
    required this.allowed,
    required this.text,
    this.reason,
  });

  factory MessageGuardResult.allow(String text) {
    return MessageGuardResult(allowed: true, text: text);
  }

  factory MessageGuardResult.block(String reason) {
    return MessageGuardResult(allowed: false, text: "", reason: reason);
  }
}
