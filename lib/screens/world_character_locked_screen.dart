import 'package:flutter/material.dart';

class WorldCharacterLockedScreen extends StatelessWidget {
  const WorldCharacterLockedScreen({super.key});

  static const bg = Color(0xFF05080B);
  static const gold = Color(0xFFE3C18B);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 0,
          title: const Text(
            'عالم الدجى',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF15191D),
                    border: Border.all(
                      color: gold.withValues(alpha: .45),
                    ),
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: gold,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'إنشاء شخصيتك في عالم الدجى',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'هذه البوابة لم تُفتح بعد.\n'
                  'عندما تُفتح، ستتمكن من إنشاء شخصيتك '
                  'والعيش داخل عالم الدجى.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111519),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .08),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_outlined,
                        color: gold,
                        size: 19,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'ستُفتح قريباً...',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
