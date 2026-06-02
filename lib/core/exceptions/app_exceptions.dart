sealed class AppException implements Exception {
  const AppException(this.mensagem);
  final String mensagem;

  @override
  String toString() => mensagem;
}

/// Falha de rede: sem conexão ou servidor inacessível (SocketException).
final class NetworkException extends AppException {
  const NetworkException()
    : super(
        'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      );
}

/// Servidor não respondeu dentro do tempo limite (TimeoutException).
final class TimeoutApiException extends AppException {
  const TimeoutApiException()
    : super('O servidor demorou para responder. Tente novamente em instantes.');
}

/// Corpo da resposta não é JSON válido ou tem estrutura inesperada.
final class ParseException extends AppException {
  const ParseException() : super('Resposta do servidor em formato inesperado.');
}

/// Token ausente, expirado ou inválido — HTTP 401.
final class UnauthorizedException extends AppException {
  const UnauthorizedException()
    : super('Sessão expirada. Faça login novamente.');
}

/// Usuário autenticado, mas sem permissão — HTTP 403.
final class ForbiddenException extends AppException {
  const ForbiddenException()
    : super('Você não tem permissão para esta operação.');
}

/// Recurso não encontrado no servidor — HTTP 404.
final class NotFoundException extends AppException {
  const NotFoundException([String m = 'Recurso não encontrado.']) : super(m);
}

/// Conflito: recurso duplicado ou regra de unicidade violada — HTTP 409.
final class ConflictException extends AppException {
  const ConflictException([String m = 'Conflito ao processar a requisição.'])
    : super(m);
}

/// Dados válidos sintaticamente, mas violam regras de negócio — HTTP 422.
final class UnprocessableException extends AppException {
  const UnprocessableException([
    String m = 'Dados inválidos para esta operação.',
  ]) : super(m);
}

/// Erro interno no servidor — HTTP 500.
final class ServerException extends AppException {
  const ServerException()
    : super('Erro interno do servidor. Tente novamente mais tarde.');
}

/// Qualquer outro código de erro HTTP não mapeado nas classes acima.
final class ApiException extends AppException {
  const ApiException(this.codigo, String mensagem) : super(mensagem);
  final int codigo;
}
