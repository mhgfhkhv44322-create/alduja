class RegisterResult {
  final bool success;
  final bool needsEmailConfirmation;
  final String? userId;
  final String? message;

  const RegisterResult({
    required this.success,
    this.needsEmailConfirmation = false,
    this.userId,
    this.message,
  });

  factory RegisterResult.success({
    required String userId,
    bool needsEmailConfirmation = false,
  }) {
    return RegisterResult(
      success: true,
      userId: userId,
      needsEmailConfirmation: needsEmailConfirmation,
    );
  }

  factory RegisterResult.failure(String message) {
    return RegisterResult(
      success: false,
      message: message,
    );
  }
}
