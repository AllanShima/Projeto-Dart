import 'package:flutter/material.dart';
import '../../domain/models/geocache.dart';
import 'difficulty_badge.dart';

/// Widget para item de cache na lista
class CacheListItem extends StatelessWidget {
  final GeoCache cache;
  final VoidCallback onTap;
  final bool isSelected;

  const CacheListItem({
    required this.cache,
    required this.onTap,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[50] : Colors.white,
        border: Border(
          left: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 4,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cache.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${cache.distance} km',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                cache.favorites.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (cache.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    DifficultyBadge(
                      level: cache.difficulty,
                      label: 'D: ${cache.difficulty} / T: ${cache.terrain}',
                    ),
                    const SizedBox(width: 8),
                    DifficultyBadge(
                      level: 1,
                      label: cache.duration,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}