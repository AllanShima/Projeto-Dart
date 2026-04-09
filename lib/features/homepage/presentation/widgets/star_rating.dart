import 'package:flutter/material.dart';

/// Widget para exibir rating em estrelas
class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;

  const StarRating({
    required this.rating,
    this.maxRating = 5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_outline,
          size: 16,
          color: Colors.amber,
        );
      }),
    );
  }
}