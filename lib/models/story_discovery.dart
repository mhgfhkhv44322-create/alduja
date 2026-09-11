class StoryDiscovery {
  final String storyId;
  final String discoveryKey;
  final DateTime? discoveredAt;

  const StoryDiscovery({
    required this.storyId,
    required this.discoveryKey,
    this.discoveredAt,
  });
}
