class City {
  final String id;
  final String name;
  final String? description;

  const City({
    required this.id,
    required this.name,
    this.description,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? 'مدينة مجهولة',
      description: map['description']?.toString(),
    );
  }
}
