class AuthResult {
  final bool success;
  final String? userId;
  final String? message;

  const AuthResult({
    required this.success,
    this.userId,
    this.message,
  });

  factory AuthResult.success(String userId) {
    return AuthResult(
      success: true,
      userId: userId,
    );
  }

  factory AuthResult.failure(String message) {
    return AuthResult(
      success: false,
      message: message,
    );
  }
}
