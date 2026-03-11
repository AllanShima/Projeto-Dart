import 'package:projeto_integrador/models/enums.dart';

class Evaluation {
  const Evaluation({
    required this.id,
    required this.userId,
    required this.cachePointId,
    required this.grade,
    required this.comment,
    required this.evaluatedAt,
  });

  final String id;
  final String userId;
  final String cachePointId;
  final Grade grade;
  final String comment;
  final DateTime evaluatedAt;

  factory Evaluation.fromJson(Map<String, dynamic> json) {
    return Evaluation(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      cachePointId: json['cache_point_id'] as String,
      grade: Grade.fromInt(json['grade'] as int),
      comment: json['comment'] as String,
      evaluatedAt: DateTime.parse(json['evaluated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'cache_point_id': cachePointId,
      'grade': grade.toJson(),
      'comment': comment,
      'evaluated_at': evaluatedAt.toIso8601String(),
    };
  }

  Evaluation copyWith({
    String? id,
    String? userId,
    String? cachePointId,
    Grade? grade,
    String? comment,
    DateTime? evaluatedAt,
  }) {
    return Evaluation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cachePointId: cachePointId ?? this.cachePointId,
      grade: grade ?? this.grade,
      comment: comment ?? this.comment,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Evaluation &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(
        id,
        userId,
        cachePointId,
        grade,
        comment,
        evaluatedAt,
      );

  @override
  String toString() => 'Evaluation(id: $id, cachePointId: $cachePointId, '
      'grade: $grade, userId: $userId)';
}
