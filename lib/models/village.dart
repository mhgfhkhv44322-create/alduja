class Village {
  final String id;
  final String cityId;
  final String name;
  final String? description;

  const Village({
    required this.id,
    required this.cityId,
    required this.name,
    this.description,
  });

  factory Village.fromMap(Map<String, dynamic> map) {
    return Village(
      id: map['id']?.toString() ?? '',
      cityId: map['city_id']?.toString() ?? '',
      name: map['name']?.toString() ?? 'قرية مجهولة',
      description: map['description']?.toString(),
    );
  }
}
