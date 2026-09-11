import 'package:flutter/material.dart';
import 'messages_screen.dart';
import 'stories_screen.dart';
import 'profile_screen.dart';
import 'cities_screen.dart';
import 'characters_screen.dart';
import 'home_action_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدجى'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'أهلاً بك في الدجى 🌙',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              'هنا تبدأ الحكايات، وتظهر الأشياء التي لم تكن تراها.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            HomeActionCard(
              icon: Icons.auto_stories_outlined,
              title: 'الحكايات',
              subtitle: 'اقرأ ما وصل إليك واكتشف العالم',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StoriesScreen(),
                  ),
                );
              },
            ),

            HomeActionCard(
              icon: Icons.mail_outline,
              title: 'الرسائل',
              subtitle: 'رسائلك ومحادثاتك في مكان واحد',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MessagesScreen(),
                  ),
                );
              },
            ),

            HomeActionCard(
              icon: Icons.location_city_outlined,
              title: 'المدن',
              subtitle: 'الأماكن التي اكتشفتها في رحلتك',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CitiesScreen(),
                  ),
                );
              },
            ),

            HomeActionCard(
              icon: Icons.people_outline,
              title: 'الشخصيات',
              subtitle: 'تعرّف على من يعيش داخل الحكايات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CharactersScreen(),
                  ),
                );
              },
            ),

            HomeActionCard(
              icon: Icons.person_outline,
              title: 'أنا',
              subtitle: 'هويتك، إنجازاتك وألقابك',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
