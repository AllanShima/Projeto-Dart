// ============= MODELS =============
class GeoCache {
  final String name;
  final String type;
  final double distance;
  final int difficulty;
  final int terrain;
  final String duration;
  final int favorites;
  final String description;
  final String tip;
  final double latitude;
  final double longitude;
  final String? badge;

  GeoCache({
    required this.name,
    required this.type,
    required this.distance,
    required this.difficulty,
    required this.terrain,
    required this.duration,
    required this.favorites,
    required this.description,
    required this.tip,
    required this.latitude,
    required this.longitude,
    this.badge,
  });
}

enum FilterType { all, found, pending }
