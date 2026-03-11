//enums de dificuldade do cachepoint
enum Dificuldade {
  facil,
  medio,
  dificil,
  extremo;

  static Dificuldade fromString(String value) {
    return Dificuldade.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => Dificuldade.medio,
    );
  }

  String toJson() => name;

//"etiqueta pra exibicao na UI"
  String get label {
    switch (this) {
      case Dificuldade.facil:
        return 'Fácil';
      case Dificuldade.medio:
        return 'Médio';
      case Dificuldade.dificil:
        return 'Difícil';
      case Dificuldade.extremo:
        return 'Extremo';
    }
  }
}

//enums de status do cachepoint
enum CachePointStatus {
  ativo,
  inativo,
  pendente,
  removido;

  static CachePointStatus fromString(String value) {
    return CachePointStatus.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => CachePointStatus.ativo,
    );
  }

  String toJson() => name;

  String get label {
    switch (this) {
      case CachePointStatus.ativo:
        return 'Ativo';
      case CachePointStatus.inativo:
        return 'Inativo';
      case CachePointStatus.pendente:
        return 'Pendente';
      case CachePointStatus.removido:
        return 'Removido';
    }
  }
}

//enums de nota pra avaliacao dos caches
enum Pontuacao {
  um(1),
  dois(2),
  tres(3),
  quatro(4),
  cinco(5);

  const Pontuacao(this.value);

  final int value;

  static Pontuacao fromInt(int value) {
    return Pontuacao.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Pontuacao.tres,
    );
  }

  int toJson() => value;
}