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
  late Future<List<City>> citiesFuture;

  @override
  void initState() {
    super.initState();
    citiesFuture = CityService().getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050912),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050912),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'المدن',
          style: TextStyle(
            color: Color(0xFFE3C477),
            fontWeight: FontWeight.w700,
          ),
        ),
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
                'تعذر الوصول إلى المدن.',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white.withOpacity(.65),
                  fontSize: 15,
                ),
              ),
            );
          }

          final cities = snapshot.data ?? [];

          if (cities.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد مدن مكتشفة بعد.',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 15,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                citiesFuture = CityService().getCities();
              });
              await citiesFuture;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount: cities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final city = cities[index];

                return Material(
                  color: Colors.transparent,
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
                      height: 220,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF182337),
                            Color(0xFF0C131F),
                          ],
                        ),
                        border: Border.all(
                          color: const Color(0xFFE3C477).withOpacity(.18),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.location_city_rounded,
                            color: const Color(0xFFE3C477).withOpacity(.8),
                            size: 32,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            city.name,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'ادخل واكتشف ما تخفيه',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
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
