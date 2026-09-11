class SessionState {
  final bool authenticated;
  final String? userId;

  const SessionState({
    required this.authenticated,
    this.userId,
  });

  const SessionState.loggedOut()
      : authenticated = false,
        userId = null;

  const SessionState.loggedIn(String id)
      : authenticated = true,
        userId = id;
}
