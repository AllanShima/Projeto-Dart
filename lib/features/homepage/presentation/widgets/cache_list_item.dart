import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'difficulty_badge.dart';

class CacheListItem extends StatelessWidget {
  final UserCacheProgress usercache;
  final VoidCallback onTap;
  final bool isSelected;

  const CacheListItem({
    required this.usercache,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CachePoint cache = usercache.cache;

    return Container(
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
                    Icon(Icons.location_on, size: 20, color: Colors.grey[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cache.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cache.dificultyLevel.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (usercache.isFound)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    const SizedBox(width: 5),
                    if (usercache.isFavorited)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
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
                      level: cache.dificultyLevel.index + 1,
                      label:
                          'D: ${cache.dificultyLevel.index + 1} / ${cache.status.label}',
                    ),
                    const SizedBox(width: 8),
                    DifficultyBadge(
                      level: 1,
                      label: cache.dificultyLevel.label,
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
