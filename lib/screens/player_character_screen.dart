import 'package:flutter/material.dart';

class PlayerCharacterScreen extends StatelessWidget {
  const PlayerCharacterScreen({super.key});

  static const bg = Color(0xFF07090B);
  static const card = Color(0xFF111417);
  static const gold = Color(0xFFD5A85B);
  static const muted = Color(0xFF8E8A82);

  Widget stat(String name, String value, IconData icon, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: .06)),
      ),
      child: Row(
        children: [
          Icon(icon, color: gold, size: 21),
          const SizedBox(width: 10),
          SizedBox(
            width: 55,
            child: Text(name,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.white.withValues(alpha: .08),
                valueColor: const AlwaysStoppedAnimation(gold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text('شخصيتي',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: Column(
          children: [
            Container(
              height: 285,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: gold.withValues(alpha: .35)),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF20201D), Color(0xFF0D0F10)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: .28,
                      child: Image.asset(
                        'assets/images/duja_login_bg.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 18,
                    top: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .55),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('المستوى 1',
                          style: TextStyle(color: gold)),
                    ),
                  ),
                  const Positioned(
                    right: 20,
                    bottom: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('المسافر',
                            style: TextStyle(color: gold, fontSize: 13)),
                        SizedBox(height: 4),
                        Text('اسم شخصيتك',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('قرية رملة  •  رحّال',
                            style: TextStyle(color: muted, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: _mini('الخبرة', '0 / 100')),
                const SizedBox(width: 10),
                Expanded(child: _mini('الذهب', '0')),
                const SizedBox(width: 10),
                Expanded(child: _mini('السمعة', '0')),
              ],
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: Text('الصفات',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: .95),
                      fontSize: 19,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            stat('القوة', '1', Icons.fitness_center, .18),
            stat('المتانة', '1', Icons.favorite_outline, .18),
            stat('السرعة', '1', Icons.bolt_outlined, .18),
            stat('الدقة', '1', Icons.my_location_outlined, .18),
            stat('الدقة', '1', Icons.my_location_outlined, .18),
            stat('الذكاء', '1', Icons.menu_book_outlined, .18),
            stat('الحكمة', '1', Icons.visibility_outlined, .18),
            stat('الحظ', '1', Icons.auto_awesome_outlined, .18),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: gold.withValues(alpha: .7)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('تطوير الصفات',
                    style: TextStyle(color: gold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mini(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: gold, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 3),
          Text(title, style: const TextStyle(color: muted, fontSize: 11)),
        ],
      ),
    );
  }
}
