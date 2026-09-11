class UnreadCount {
  final int count;

  const UnreadCount({
    this.count = 0,
  });

  bool get hasUnread => count > 0;
}
