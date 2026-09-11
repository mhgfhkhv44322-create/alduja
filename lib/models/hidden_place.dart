class HiddenPlace {
  final String key;
  final String name;
  final String description;
  final String icon;

  const HiddenPlace({
    required this.key,
    required this.name,
    required this.description,
    this.icon = 'explore',
  });
}
