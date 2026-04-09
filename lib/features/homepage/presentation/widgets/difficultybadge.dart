import 'package:flutter/material.dart';

/// Widget para exibir badges de dificuldade
class DifficultyBadge extends StatelessWidget {
  final int level; // 1-5
  final String label;

  const DifficultyBadge({
    required this.level,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
}