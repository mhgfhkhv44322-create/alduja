class LogoutResult {
  final bool success;
  final String? message;

  const LogoutResult({
    required this.success,
    this.message,
  });

  factory LogoutResult.success() {
    return const LogoutResult(success: true);
  }

  factory LogoutResult.failure(String message) {
    return LogoutResult(
      success: false,
      message: message,
    );
  }
}
