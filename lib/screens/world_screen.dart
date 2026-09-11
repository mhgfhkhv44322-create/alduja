import 'package:flutter/material.dart';
import 'lore_screen.dart';
import '../models/city.dart';
import '../services/city_service.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({super.key});

  @override
  State<WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  late Future<List<City>> citiesFuture;

  @override
  void initState() {
    super.initState();
    citiesFuture = CityService().getCities();
  }

  Future<void> refreshWorld() async {
    setState(() {
      citiesFuture = CityService().getCities();
    });
    await citiesFuture;
  }

  @override
  void _openLore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoreScreen()),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE5C77A),
        foregroundColor: const Color(0xFF070B14),
        onPressed: _openLore,
        child: const Icon(Icons.auto_awesome_outlined),
      ),
      appBar: AppBar(
        title: const Text('عالم الدجى'),
      ),
      body: FutureBuilder<List<City>>(
        future: citiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final cities = snapshot.data ?? [];

          if (cities.isEmpty) {
            return const Center(
              child: Text(
                'العالم بعده مخفي...\nابدأ باكتشاف الحكايات.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: refreshWorld,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cities.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final city = cities[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.location_city_outlined,
                      ),
                    ),
                    title: Text(city.name),
                    subtitle: Text(
                      city.description ?? 'مدينة من عالم الدجى',
                    ),
                    trailing: const Icon(
                      Icons.chevron_left,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
