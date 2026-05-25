import 'package:flutter/material.dart';

import 'package:projeto_integrador/models/cachepoint.dart';

class CacheListTileMobile extends StatelessWidget {
  final CachePoint cache;
  final VoidCallback onTap;

  const CacheListTileMobile({
    super.key,
    required this.cache,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cache.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
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
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MobileMetricBadge(
                    icon: Icons.terrain,
                    label: cache.dificultyLevel.label,
                  ),
                  _MobileMetricBadge(
                    icon: Icons.star,
                    label: '${cache.dificultyLevel.index + 1}/5',
                  ),
                  _MobileMetricBadge(
                    icon: Icons.info_outline,
                    label: cache.status.label,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMetricBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MobileMetricBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.blue[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }
}
