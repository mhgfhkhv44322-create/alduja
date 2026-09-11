class AccountState {
  final bool isLoggedIn;
  final String? userId;
  final String? email;

  const AccountState({
    required this.isLoggedIn,
    this.userId,
    this.email,
  });

  factory AccountState.loggedOut() {
    return const AccountState(isLoggedIn: false);
  }

  factory AccountState.loggedIn({
    required String userId,
    String? email,
  }) {
    return AccountState(
      isLoggedIn: true,
      userId: userId,
      email: email,
    );
  }
}
