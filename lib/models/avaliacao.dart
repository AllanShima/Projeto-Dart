import 'package:projeto_integrador/models/enums.dart';

class Avaliacao {
  const Avaliacao({
    required this.id,
    required this.userId,
    required this.cachePointId,
    required this.pontuacao,
    required this.comment,
    required this.evaluatedAt,
  });

  final String id;
  final String userId;
  final String cachePointId;
  final Pontuacao pontuacao;
  final String comment;
  final DateTime evaluatedAt;

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      cachePointId: json['cache_point_id'] as String,
      pontuacao: Pontuacao.fromInt(json['pontuacao'] as int),
      comment: json['comment'] as String,
      evaluatedAt: DateTime.parse(json['evaluated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'cache_point_id': cachePointId,
      'pontuacao': pontuacao.toJson(),
      'comment': comment,
      'evaluated_at': evaluatedAt.toIso8601String(),
    };
  }

  Avaliacao copyWith({
    String? id,
    String? userId,
    String? cachePointId,
    Pontuacao? pontuacao,
    String? comment,
    DateTime? evaluatedAt,
  }) {
    return Avaliacao(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cachePointId: cachePointId ?? this.cachePointId,
      pontuacao: pontuacao ?? this.pontuacao,
      comment: comment ?? this.comment,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Avaliacao &&
        other.id == id &&
        other.userId == userId &&
        other.cachePointId == cachePointId &&
        other.pontuacao == pontuacao &&
        other.comment == comment &&
        other.evaluatedAt == evaluatedAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        userId,
        cachePointId,
        pontuacao,
        comment,
        evaluatedAt,
      );

  @override
  String toString() => 'Avaliacao(id: $id, cachePointId: $cachePointId, '
      'pontuacao: $pontuacao, userId: $userId)';
}
