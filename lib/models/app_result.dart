class AppResult<T> {
  final bool success;
  final T? data;
  final String? message;

  const AppResult({
    required this.success,
    this.data,
    this.message,
  });

  factory AppResult.success([T? data]) {
    return AppResult(
      success: true,
      data: data,
    );
  }

  factory AppResult.failure(String message) {
    return AppResult(
      success: false,
      message: message,
    );
  }
}
