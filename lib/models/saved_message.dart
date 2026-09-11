class SavedMessage {
  final String messageId;
  final bool isSaved;

  const SavedMessage({
    required this.messageId,
    required this.isSaved,
  });

  SavedMessage copyWith({
    bool? isSaved,
  }) {
    return SavedMessage(
      messageId: messageId,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
