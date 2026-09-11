class CharacterUnlockResult {
  final bool success;
  final String? characterId;
  final String? error;

  const CharacterUnlockResult({
    required this.success,
    this.characterId,
    this.error,
  });

  factory CharacterUnlockResult.success(String characterId) {
    return CharacterUnlockResult(
      success: true,
      characterId: characterId,
    );
  }

  factory CharacterUnlockResult.failure(String error) {
    return CharacterUnlockResult(
      success: false,
      error: error,
    );
  }
}
