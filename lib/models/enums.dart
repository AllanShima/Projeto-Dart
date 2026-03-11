//enums de DificultyLevel do cachepoint
enum DificultyLevel {
  easy,
  medium,
  hard,
  extreme;

  static DificultyLevel fromString(String value) {
    return DificultyLevel.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => DificultyLevel.medium,
    );
  }

  String toJson() => name;

//"etiqueta pra exibicao na UI"
  String get label {
    switch (this) {
      case DificultyLevel.easy:
        return 'Fácil';
      case DificultyLevel.medium:
        return 'Médio';
      case DificultyLevel.hard:
        return 'Difícil';
      case DificultyLevel.extreme:
        return 'Extremo';
    }
  }
}

//enums de status do cachepoint
enum CachePointStatus {
  active,
  inactive,
  pending,
  removed;

  static CachePointStatus fromString(String value) {
    return CachePointStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => CachePointStatus.active,
    );
  }

  String toJson() => name;

  String get label {
    switch (this) {
      case CachePointStatus.active:
        return 'Ativo';
      case CachePointStatus.inactive:
        return 'Inativo';
      case CachePointStatus.pending:
        return 'Pendente';
      case CachePointStatus.removed:
        return 'Removido';
    }
  }
}

//enums de nota pra avaliacao dos caches
enum Grade {
  one(1),
  two(2),
  three(3),
  four(4),
  five(5);

  const Grade(this.value);

  final int value;

  static Grade fromInt(int value) {
    return Grade.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Grade.three,
    );
  }

  int toJson() => value;
}