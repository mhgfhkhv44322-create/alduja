import 'package:flutter/material.dart';
import '../models/city.dart';
import '../services/city_service.dart';
import 'city_detail_screen.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({super.key});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  late Future<List<City>> _future;

  @override
  void initState() {
    super.initState();
    _future = CityService().getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07090E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10131B),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المدن',
          style: TextStyle(
            color: Color(0xFFE3C477),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<City>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE3C477),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'تعذر تحميل المدن',
                style: TextStyle(color: Colors.white54, fontSize: 18),
              ),
            );
          }

          final cities = snapshot.data ?? [];

          if (cities.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد مدن في العالم بعد.',
                style: TextStyle(color: Colors.white54, fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(18),
            itemCount: cities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final city = cities[index];

              return Material(
                color: const Color(0xFF11141C),
                borderRadius: BorderRadius.circular(28),
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CityDetailScreen(city: city),
                      ),
                    );
                  },
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color(0xFFE3C477).withOpacity(.12),
                      ),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3C477),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.location_city_rounded,
                              size: 38,
                              color: Color(0xFF11131A),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  city.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                const Text(
                                  'مكان في الدجى… وله حكايات لم تُفتح بعد.',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFE3C477),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
