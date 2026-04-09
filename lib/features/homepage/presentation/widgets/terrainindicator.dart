import 'package:flutter/material.dart';

/// Widget para exibir ícones de terreno
class TerrainIndicator extends StatelessWidget {
  final int level; // 1-5
  final String label;

  const TerrainIndicator({
    required this.level,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(level, (index) {
            return const Icon(
              Icons.terrain,
              size: 14,
              color: Colors.grey,
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}