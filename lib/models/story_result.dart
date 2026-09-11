import 'story.dart';

class StoryResult {
  final bool success;
  final Story? story;
  final String? error;

  const StoryResult({
    required this.success,
    this.story,
    this.error,
  });

  factory StoryResult.success(Story story) {
    return StoryResult(
      success: true,
      story: story,
    );
  }

  factory StoryResult.failure(String error) {
    return StoryResult(
      success: false,
      error: error,
    );
  }
}
