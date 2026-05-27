import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../exceptions/app_exceptions.dart';

abstract final class ApiUris {
  static const _host = 'api.geoquest.app';
  static const _basePath = '/v1';

  /// `GET /v1/caches` ou `GET /v1/caches?lat=...&lng=...&raio_km=...`
  static Uri caches([Map<String, String>? query]) =>
      Uri.https(_host, '$_basePath/caches', query);

  /// `GET|PATCH|DELETE /v1/caches/:id`
  static Uri cache(String id) => Uri.https(_host, '$_basePath/caches/$id');

  /// `GET|POST /v1/caches/:id/avaliacoes`
  static Uri avaliacoes(String cacheId) =>
      Uri.https(_host, '$_basePath/caches/$cacheId/avaliacoes');

  /// `POST /v1/caches/:id/checkin`
  static Uri checkin(String cacheId) =>
      Uri.https(_host, '$_basePath/caches/$cacheId/checkin');

  static Uri login() => Uri.https(_host, '$_basePath/auth/login');
  static Uri register() => Uri.https(_host, '$_basePath/auth/register');
  static Uri user(String id) => Uri.https(_host, '$_basePath/users/$id');

  static Uri progresso(String userId) =>
      Uri.https(_host, '$_basePath/users/$userId/progress');
  static Uri progressoItem(String userId, String cachepointId) =>
      Uri.https(_host, '$_basePath/users/$userId/progress/$cachepointId');
}

abstract final class Cabecalhos {
  /// Para GET e DELETE (sem corpo).
  static Map<String, String> leitura(String token) => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  /// Para POST, PUT e PATCH (com corpo JSON).
  static Map<String, String> escrita(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // Para endpoints públicos sem autenticação (login, register).
  static Map<String, String> publico() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

extension ResponseX on http.Response {
  void verificarStatus() {
    if (statusCode >= 200 && statusCode < 300) return;
    throw switch (statusCode) {
      401 => const UnauthorizedException(),
      403 => const ForbiddenException(),
      404 => const NotFoundException(),
      409 => const ConflictException(),
      422 => const UnprocessableException(),
      500 => const ServerException(),
      _ => ApiException(statusCode, body),
    };
  }
}

Future<http.Response> executar(Future<http.Response> Function() fn) async {
  try {
    return await fn();
  } on SocketException {
    throw const NetworkException();
  } on TimeoutException {
    throw const TimeoutApiException();
  } on FormatException {
    throw const ParseException();
  }
}

List<Map<String, dynamic>> decodificarLista(http.Response response) {
  try {
    final decoded = jsonDecode(response.body);
    if (decoded is! List) throw const ParseException();
    return decoded.cast<Map<String, dynamic>>();
  } on FormatException {
    throw const ParseException();
  } on TypeError {
    throw const ParseException();
  }
}

Map<String, dynamic> decodificarObjeto(http.Response response) {
  try {
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) throw const ParseException();
    return decoded;
  } on FormatException {
    throw const ParseException();
  } on TypeError {
    throw const ParseException();
  }
}
