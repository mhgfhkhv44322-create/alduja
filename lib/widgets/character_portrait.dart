import 'package:flutter/material.dart';

class CharacterPortrait extends StatelessWidget {
  final String name;
  final bool locked;
  final double size;

  const CharacterPortrait({
    super.key,
    required this.name,
    this.locked = false,
    this.size = 92,
  });

  IconData get _icon {
    if (name.contains('سادن')) return Icons.menu_book_rounded;
    if (name.contains('رمح')) return Icons.shield_rounded;
    if (name.contains('راوي')) return Icons.local_fire_department_rounded;
    if (name.contains('مريم')) return Icons.nightlight_round;
    if (name.contains('ريح')) return Icons.air_rounded;
    return Icons.person_rounded;
  }

  List<Color> get _gradient {
    if (name.contains('سادن')) {
      return const [Color(0xFFE3C477), Color(0xFF80652D)];
    }
    if (name.contains('رمح')) {
      return const [Color(0xFF4A4D56), Color(0xFF151820)];
    }
    if (name.contains('راوي')) {
      return const [Color(0xFFB66A3C), Color(0xFF321B14)];
    }
    if (name.contains('مريم')) {
      return const [Color(0xFF53688F), Color(0xFF171C2D)];
    }
    if (name.contains('ريح')) {
      return const [Color(0xFF78958A), Color(0xFF17211E)];
    }
    return const [Color(0xFF555A68), Color(0xFF171920)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: locked
              ? const [Color(0xFF292C35), Color(0xFF111319)]
              : _gradient,
        ),
        border: Border.all(
          color: locked
              ? Colors.white12
              : Colors.white.withValues(alpha: .16),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .28),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          locked ? Icons.lock_outline_rounded : _icon,
          size: size * .40,
          color: locked
              ? Colors.white24
              : const Color(0xFFF4E6BE),
        ),
      ),
    );
  }
}
