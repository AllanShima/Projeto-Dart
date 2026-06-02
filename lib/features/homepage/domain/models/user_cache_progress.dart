import 'package:projeto_integrador/models/cachepoint.dart';

class UserCacheProgress {
  final CachePoint cache;
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

  UserCacheProgress copyWith({
    CachePoint? cache,
    String? userId,
    bool? isFavorited,
    bool? isFound,
    DateTime? foundAt,
  }) {
    return UserCacheProgress(
      cache: cache ?? this.cache,
      userId: userId ?? this.userId,
      isFavorited: isFavorited ?? this.isFavorited,
      isFound: isFound ?? this.isFound,
      foundAt: foundAt ?? this.foundAt,
    );
  }
}

enum FilterType { all, found, pending }
