class CacheValidators {
  CacheValidators._();

  static String? required(String? value, {String fieldName = 'Este campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }

    return null;
  }

  static String? address(String? value) {
    final err = required(value, fieldName: 'O endereço');
    if (err != null) return err;

    return null;
  }

  static String? description(String? value) {
    final err = required(value, fieldName: 'A descrição');
    if (err != null) return err;

    return null;
  }

  static String? hint(String? value) {
    if (value == null || value.trim().isEmpty) return 'A dica é obrigatória';

    return null;
  }

  static String? Function(String?) dropdown({String fieldName = 'Este campo'}) {
    return (String? value) {
      if (value == null || value.isEmpty) return '$fieldName é obrigatório';

      return null;
    };
  }
}
