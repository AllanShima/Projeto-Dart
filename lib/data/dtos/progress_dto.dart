class ProgressDto {
  const ProgressDto({
    required this.userId,
    required this.cachepointId,
    required this.isFavorited,
    required this.isFound,
    this.foundAt,
  });

  final String userId;
  final String cachepointId;
  final bool isFavorited;
  final bool isFound;
  final DateTime? foundAt;

  factory ProgressDto.fromJson(Map<String, dynamic> json) {
    return ProgressDto(
      userId: json['user_id'] as String,
      cachepointId: json['cachepoint_id'] as String,
      isFavorited: json['is_favorited'] as bool,
      isFound: json['is_found'] as bool,
      foundAt: json['found_at'] == null
          ? null
          : DateTime.parse(json['found_at'] as String),
    );
  }

  /// Converte para o formato do SQLite (camelCase, int para bool)
  Map<String, dynamic> toMap() => {
    'userId': userId,
    'cachepointId': cachepointId,
    'isFavorited': isFavorited ? 1 : 0,
    'isFound': isFound ? 1 : 0,
    'foundAt': foundAt?.toIso8601String(),
  };
}
