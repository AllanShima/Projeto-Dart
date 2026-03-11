import 'package:projeto_integrador/models/enums.dart';

class CachePoint {
  const CachePoint({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.latitude,
    required this.longitude,
    required this.dificuldade,
    required this.qrCodeContent,
    required this.qrCodeImageUrl,
    required this.creatorId,
    required this.createdAt,
    this.status = CachePointStatus.ativo,
  });

  final String id;
  final String titulo;
  final String descricao;
  final double latitude;
  final double longitude;
  final Dificuldade dificuldade;

  /// String única codificada no QR Code físico para validar a presença.
  final String qrCodeContent;

  /// URL da imagem do QR Code gerada pela API para impressão/exibição.
  final String qrCodeImageUrl;

  final String creatorId;
  final DateTime createdAt;
  final CachePointStatus status;

  // ---------------------------------------------------------------------------
  // Desserialização
  // ---------------------------------------------------------------------------

  factory CachePoint.fromJson(Map<String, dynamic> json) {
    return CachePoint(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      dificuldade: Dificuldade.fromString(
        json['difficulty_level'] as String,
      ),
      qrCodeContent: json['qr_code_content'] as String,
      qrCodeImageUrl: json['qr_code_image_url'] as String,
      creatorId: json['creator_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: CachePointStatus.fromString(
        json['status'] as String? ?? 'ativo',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'latitude': latitude,
      'longitude': longitude,
      'dificuldade': dificuldade.toJson(),
      'qr_code_content': qrCodeContent,
      'qr_code_image_url': qrCodeImageUrl,
      'creator_id': creatorId,
      'created_at': createdAt.toIso8601String(),
      'status': status.toJson(),
    };
  }

  CachePoint copyWith({
    String? id,
    String? titulo,
    String? descricao,
    double? latitude,
    double? longitude,
    Dificuldade? dificuldade,
    String? qrCodeContent,
    String? qrCodeImageUrl,
    String? creatorId,
    DateTime? createdAt,
    CachePointStatus? status,
  }) {
    return CachePoint(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      dificuldade: dificuldade ?? this.dificuldade,
      qrCodeContent: qrCodeContent ?? this.qrCodeContent,
      qrCodeImageUrl: qrCodeImageUrl ?? this.qrCodeImageUrl,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is CachePoint &&
        other.id == id &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.dificuldade == dificuldade &&
        other.qrCodeContent == qrCodeContent &&
        other.qrCodeImageUrl == qrCodeImageUrl &&
        other.creatorId == creatorId &&
        other.createdAt == createdAt &&
        other.status == status;


  @override
  int get hashCode => Object.hash(
        id,
        titulo,
        descricao,
        latitude,
        longitude,
        dificuldade,
        qrCodeContent,
        qrCodeImageUrl,
        creatorId,
        createdAt,
        status,
      );

  @override
  String toString() => 'CachePoint(id: $id, titulo: $titulo, '
      'latitude: $latitude, longitude: $longitude, '
      'difficulty: ${dificuldade.name}, status: ${status.name})';
}