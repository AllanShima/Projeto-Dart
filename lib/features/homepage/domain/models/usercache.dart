class UserCacheProgress {
  final String cacheId;
  final String userId;
  final bool isFavorited;
  final bool isFound;
  final DateTime? foundAt;

  const UserCacheProgress({
    required this.cacheId,
    required this.userId,
    this.isFavorited = false,
    this.isFound = false,
    this.foundAt,
  });
}