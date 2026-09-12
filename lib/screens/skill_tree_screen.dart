import 'package:flutter/material.dart';

class SkillTreeScreen extends StatelessWidget {
  const SkillTreeScreen({super.key});

  static const bg = Color(0xFF07090B);
  static const gold = Color(0xFFD5A85B);
  static const muted = Color(0xFF8E8A82);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text('شجرة المهارات',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111417),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: gold.withValues(alpha: .25)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('نقاط غير موزعة',
                      style: TextStyle(color: Colors.white)),
                  Text('3',
                      style: TextStyle(
                          color: gold,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _node('⚔', 'إتقان السيف', '1 / 5', true),
            _line(),
            Row(
              children: [
                Expanded(child: _branch('◈', 'الضربة القوية', '0 / 3')),
                const SizedBox(width: 12),
                Expanded(child: _branch('✦', 'القتال الدفاعي', '0 / 3')),
              ],
            ),
            _line(),
            Row(
              children: [
                Expanded(child: _branch('◆', 'كسر الدروع', 'مغلق')),
                const SizedBox(width: 12),
                Expanded(child: _branch('⚔', 'هجوم متسلسل', '0 / 1')),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111417),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: .06)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('إتقان السيف',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 7),
                  Text('يزيد ضرر السيف بنسبة 5% لكل مستوى.',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: muted, height: 1.5)),
                  SizedBox(height: 14),
                  Text('المتطلبات: المستوى 1',
                      style: TextStyle(color: gold, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('تعلم المهارة',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _node(String icon, String title, String level, bool active) {
    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF15181B),
            border: Border.all(color: active ? gold : Colors.white24, width: 2),
            boxShadow: active
                ? [BoxShadow(color: gold.withValues(alpha: .18), blurRadius: 25)]
                : null,
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 28, color: gold)),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 3),
        Text(level, style: const TextStyle(color: muted, fontSize: 11)),
      ],
    );
  }

  Widget _branch(String icon, String title, String level) {
    final locked = level == 'مغلق';
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFF101315),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: locked ? Colors.white10 : gold.withValues(alpha: .28)),
      ),
      child: Column(
        children: [
          Text(locked ? '🔒' : icon,
              style: TextStyle(
                  color: locked ? Colors.white30 : gold, fontSize: 22)),
          const SizedBox(height: 7),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(height: 4),
          Text(level,
              style: TextStyle(
                  color: locked ? Colors.white30 : muted, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _line() => Container(
        width: 2,
        height: 30,
        margin: const EdgeInsets.symmetric(vertical: 2),
        color: gold.withValues(alpha: .35),
      );
}
