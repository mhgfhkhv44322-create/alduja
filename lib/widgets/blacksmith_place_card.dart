import 'package:flutter/material.dart';
import '../screens/blacksmith_screen.dart';

class BlacksmithPlaceCard extends StatelessWidget {
  const BlacksmithPlaceCard({super.key});

  static const gold = Color(0xFFD5A85B);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const BlacksmithScreen(),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF111417),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: gold.withValues(alpha: .25)),
        ),
        child: const Row(
          children: [
            Icon(Icons.local_fire_department_outlined,
                color: gold, size: 32),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'محل الحدادة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'اصنع سلاحك، أصلحه وطوّره عند نُعمان الحداد',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF9A9489),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_left, color: gold),
          ],
        ),
      ),
    );
  }
}
