import 'package:projeto_integrador/models/enums.dart';

class CachePoint {
  const CachePoint({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.dificultyLevel,
    required this.qrCodeContent,
    required this.qrCodeImageUrl,
    required this.creatorId,
    required this.createdAt,
    this.status = CachePointStatus.active,
  });

  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final DificultyLevel dificultyLevel;

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
      title: json['title'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      dificultyLevel: DificultyLevel.fromString(
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
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'difficulty_level': dificultyLevel.toJson(),
      'qr_code_content': qrCodeContent,
      'qr_code_image_url': qrCodeImageUrl,
      'creator_id': creatorId,
      'created_at': createdAt.toIso8601String(),
      'status': status.toJson(),
    };
  }

  CachePoint copyWith({
    String? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    DificultyLevel? dificultyLevel,
    String? qrCodeContent,
    String? qrCodeImageUrl,
    String? creatorId,
    DateTime? createdAt,
    CachePointStatus? status,
  }) {
    return CachePoint(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      dificultyLevel: dificultyLevel ?? this.dificultyLevel,
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
        other.id == id;


  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        latitude,
        longitude,
        dificultyLevel,
        qrCodeContent,
        qrCodeImageUrl,
        creatorId,
        createdAt,
        status,
      );

  @override
  String toString() => 'CachePoint(id: $id, title: $title, '
      'latitude: $latitude, longitude: $longitude, '
      'difficulty: ${dificultyLevel.name}, status: ${status.name})';
}