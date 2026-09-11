class AppError {
  final String message;
  final String? code;

  const AppError({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return code == null ? message : '$code: $message';
  }
}
