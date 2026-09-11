class LoginResult {
  final bool success;
  final String? userId;
  final String? message;

  const LoginResult({
    required this.success,
    this.userId,
    this.message,
  });

  factory LoginResult.success(String userId) {
    return LoginResult(
      success: true,
      userId: userId,
    );
  }

  factory LoginResult.failure(String message) {
    return LoginResult(
      success: false,
      message: message,
    );
  }
}
