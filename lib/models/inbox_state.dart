import 'inbox_message.dart';

class InboxState {
  final bool loading;
  final List<InboxMessage> messages;
  final String? error;

  const InboxState({
    this.loading = false,
    this.messages = const [],
    this.error,
  });

  InboxState copyWith({
    bool? loading,
    List<InboxMessage>? messages,
    String? error,
  }) {
    return InboxState(
      loading: loading ?? this.loading,
      messages: messages ?? this.messages,
      error: error,
    );
  }
}
