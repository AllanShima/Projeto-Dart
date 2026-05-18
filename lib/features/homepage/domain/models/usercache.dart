import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';

class UserCacheProgress {
  final GeoCache cache;
  final String userId;
  final bool isFavorited;
  final bool isFound;
  final DateTime? foundAt;

  const UserCacheProgress({
    required this.cache,
    required this.userId,
    this.isFavorited = false,
    this.isFound = false,
    this.foundAt,
  });
}