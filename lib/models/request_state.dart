class RequestState<T> {
  final bool loading;
  final T? data;
  final String? error;

  const RequestState({
    this.loading = false,
    this.data,
    this.error,
  });

  const RequestState.loading()
      : loading = true,
        data = null,
        error = null;

  const RequestState.success(T value)
      : loading = false,
        data = value,
        error = null;

  const RequestState.failure(String message)
      : loading = false,
        data = null,
        error = message;
}
