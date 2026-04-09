import 'package:flutter/material.dart';

/// Widget para filtros
class FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? count;

  const FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey[400] : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count != null ? '$label ($count)' : label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}