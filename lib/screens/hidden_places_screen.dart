import 'package:flutter/material.dart';
import '../models/hidden_place.dart';
import '../services/hidden_place_service.dart';

class HiddenPlacesScreen extends StatefulWidget {
  const HiddenPlacesScreen({super.key});

  @override
  State<HiddenPlacesScreen> createState() => _HiddenPlacesScreenState();
}

class _HiddenPlacesScreenState extends State<HiddenPlacesScreen> {
  final service = HiddenPlaceService();

  final places = const [
    HiddenPlace(
      key: 'ancient_well',
      name: 'البئر القديم',
      description: 'مكان لم يظهر بعد... وربما لا ينبغي أن يظهر.',
    ),
  ];

  Map<String, bool> discovered = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    for (final place in places) {
      final value = await service.isDiscovered(place.key);
      if (mounted) {
        setState(() => discovered[place.key] = value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأماكن الخفية'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          final visible = discovered[place.key] == true;

          return Card(
            child: ListTile(
              leading: Icon(
                visible
                    ? Icons.water_drop_outlined
                    : Icons.help_outline,
              ),
              title: Text(
                visible ? place.name : 'مكان مجهول',
              ),
              subtitle: Text(
                visible
                    ? place.description
                    : 'لم يُكتشف هذا المكان بعد.',
              ),
            ),
          );
        },
      ),
    );
  }
}
