import 'package:flutter/material.dart';

class BlacksmithScreen extends StatefulWidget {
  const BlacksmithScreen({super.key});

  @override
  State<BlacksmithScreen> createState() => _BlacksmithScreenState();
}

class _BlacksmithScreenState extends State<BlacksmithScreen> {
  static const bg = Color(0xFF07090B);
  static const card = Color(0xFF121517);
  static const gold = Color(0xFFD5A85B);
  static const muted = Color(0xFF9A9489);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'مَحلّ الحداد',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
          Positioned.fill(child: Image.asset('assets/images/duja.png', fit: BoxFit.cover)),
          Container(color: Colors.black.withValues(alpha: .62)),
          ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: gold.withValues(alpha: .35)),
              gradient: const LinearGradient(
                colors: [Color(0xFF282018), Color(0xFF101214)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department_outlined,
                    color: gold, size: 54),
                SizedBox(height: 10),
                Text(
                  'نُعمان الحداد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'أصنع السلاح الذي يبقى حين تنتهي الرحلة.',
                  style: TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _action(Icons.build_outlined, 'إصلاح السلاح',
              'أعد متانة سلاحك إلى حالتها الكاملة'),
          _action(Icons.hardware_outlined, 'صناعة سلاح',
              'اصنع خنجراً أو سيفاً أو فأساً أو قوساً'),
          _action(Icons.upgrade_outlined, 'ترقية السلاح',
              'حسّن الضرر والمتانة بمواد نادرة'),
          _action(Icons.delete_outline, 'تفكيك السلاح',
              'استرجع بعض المواد من سلاح قديم'),
          const SizedBox(height: 18),
          const Text(
            'الوصفات المعروفة',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _recipe('خنجر الرحّال', 'خنجر', '15 ذهب', 'حديد ×2 • جلد ×1'),
          _recipe('سيف بدوي', 'سيف', '35 ذهب',
              'حديد ×5 • خشب ×1 • جلد ×1'),
          _recipe('فأس القوافل', 'فأس', '45 ذهب', 'حديد ×6 • خشب ×2'),
          _recipe('قوس الصحراء', 'قوس', '30 ذهب', 'خشب ×4 • جلد ×2'),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: gold, size: 27),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(description,
                    style: const TextStyle(color: muted, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.chevron_left, color: muted),
        ],
      ),
    );
  }

  Widget _recipe(
      String name, String type, String cost, String materials) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: gold.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.gavel, color: gold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text(type,
                    style: const TextStyle(color: muted, fontSize: 11)),
                Text(materials,
                    style: const TextStyle(color: muted, fontSize: 10)),
              ],
            ),
          ),
          Text(cost, style: const TextStyle(color: gold, fontSize: 12)),
        ],
      ),
    );
  }
}
