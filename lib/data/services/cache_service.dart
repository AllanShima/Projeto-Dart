import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/http/api_client.dart';
import '../../models/cachepoint.dart';

class CacheService {
  const CacheService(this._client);

  final http.Client _client;

  // GET /caches
  Future<List<CachePoint>> listarCaches({
    required String token,
    double? lat,
    double? lng,
    double? raioKm,
  }) async {
    final queryParams = <String, String>{};
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lng != null) queryParams['lng'] = lng.toString();
    if (raioKm != null) queryParams['raio_km'] = raioKm.toString();

    final response = await executar(
      () => _client
          .get(
            ApiUris.caches(queryParams.isEmpty ? null : queryParams),
            headers: Cabecalhos.leitura(token),
          )
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return decodificarLista(response).map(CachePoint.fromJson).toList();
  }

  // GET /caches/:id
  Future<CachePoint> buscarCache({
    required String token,
    required String id,
  }) async {
    final response = await executar(
      () => _client
          .get(ApiUris.cache(id), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return CachePoint.fromJson(decodificarObjeto(response));
  }

  // POST /caches
  Future<CachePoint> criarCache({
    required String token,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String difficultyLevel,
    String? tip,
  }) async {
    final response = await executar(
      () => _client
          .post(
            ApiUris.caches(),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode({
              'title': title,
              'description': description,
              'latitude': latitude,
              'longitude': longitude,
              'difficulty_level': difficultyLevel,
              'tip': tip,
            }),
          )
          .timeout(const Duration(seconds: 15)),
    );

    response.verificarStatus();
    return CachePoint.fromJson(decodificarObjeto(response));
  }

  // PATCH /caches/:id
  Future<CachePoint> atualizarCache({
    required String token,
    required String id,
    String? title,
    String? description,
    String? status,
  }) async {
    final campos = <String, dynamic>{};
    if (title != null) campos['title'] = title;
    if (description != null) campos['description'] = description;
    if (status != null) campos['status'] = status;

    final response = await executar(
      () => _client
          .patch(
            ApiUris.cache(id),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode(campos),
          )
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return CachePoint.fromJson(decodificarObjeto(response));
  }

  // DELETE /caches/:id
  Future<void> removerCache({required String token, required String id}) async {
    final response = await executar(
      () => _client
          .delete(ApiUris.cache(id), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      response.verificarStatus();
    }
  }
}
