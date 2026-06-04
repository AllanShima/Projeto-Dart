// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../../core/http/api_client.dart';
import '../../models/cachepoint.dart';

import 'package:projeto_integrador/models/enums.dart';

List<CachePoint> cacheList = [
  CachePoint(
    id: "xyz98765",
    title: "Caverna Urbana",
    description: "Debbaixo da antiga ponte ferroviária desativada.",
    latitude: -23.55250,
    longitude: -46.632100,
    dificultyLevel: DificultyLevel.hard,
    qrCodeContent: "geo-cache-003",
    qrCodeImageUrl: "https://link.com/qr3.png",
    creatorId: "user_01",
    createdAt: DateTime.now(),
    status: CachePointStatus.active,
  ),
  CachePoint(
    id: "qwe45678",
    title: "Praça Central",
    description: "Escondido na base do monumento histórico.",
    latitude: -23.55390,
    longitude: -46.635500,
    dificultyLevel: DificultyLevel.easy,
    qrCodeContent: "geo-cache-004",
    qrCodeImageUrl: "https://link.com/qr4.png",
    creatorId: "user_03",
    createdAt: DateTime.now(),
    status: CachePointStatus.active,
    tip: "Lado esquerdo da placa de bronze.",
  ),
  CachePoint(
    id: "rty11223",
    title: "Trilha da Cachoeira",
    description: "No início da trilha principal, logo após a ponte de madeira.",
    latitude: -23.55600,
    longitude: -46.631000,
    dificultyLevel: DificultyLevel.extreme,
    qrCodeContent: "geo-cache-005",
    qrCodeImageUrl: "https://link.com/qr5.png",
    creatorId: "user_04",
    createdAt: DateTime.now(),
    status: CachePointStatus.active,
  ),
  CachePoint(
    id: "uio44556",
    title: "Biblioteca Velha",
    description: "Perto do jardim interno nos fundos do prédio.",
    latitude: -23.54800,
    longitude: -46.636000,
    dificultyLevel: DificultyLevel.hard,
    qrCodeContent: "geo-cache-006",
    qrCodeImageUrl: "https://link.com/qr6.png",
    creatorId: "user_02",
    createdAt: DateTime.now(),
    status: CachePointStatus.inactive,
  ),
];

class CacheService {
  CacheService();

  // GET /caches
  Future<List<CachePoint>> listarCaches({
    required String token,
    double? lat,
    double? lng,
    double? raioKm,
  }) async {
    // final queryParams = <String, String>{};
    // if (lat != null) queryParams['lat'] = lat.toString();
    // if (lng != null) queryParams['lng'] = lng.toString();
    // if (raioKm != null) queryParams['raio_km'] = raioKm.toString();

    // final response = await executar(
    //   () => _client
    //       .get(
    //         ApiUris.caches(queryParams.isEmpty ? null : queryParams),
    //         headers: Cabecalhos.leitura(token),
    //       )
    //       .timeout(const Duration(seconds: 10)),
    // );

    // response.verificarStatus();
    // return decodificarLista(response).map(CachePoint.fromJson).toList();
    return cacheList;
  }

  // GET /caches/:id
  Future<CachePoint> buscarCache({
    required String token,
    required String id,
  }) async {
    // final response = await executar(
    //   () => _client
    //       .get(ApiUris.cache(id), headers: Cabecalhos.leitura(token))
    //       .timeout(const Duration(seconds: 10)),
    // );

    // response.verificarStatus();
    // return CachePoint.fromJson(decodificarObjeto(response));
    return cacheList.firstWhere((cache) => cache.id == id);
  }

  // POST /caches
  Future<CachePoint> criarCache({
    required String token,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required DificultyLevel difficultyLevel,
    String? tip,
  }) async {
    // final response = await executar(
    //   () => _client
    //       .post(
    //         ApiUris.caches(),
    //         headers: Cabecalhos.escrita(token),
    //         body: jsonEncode({
    //           'title': title,
    //           'description': description,
    //           'latitude': latitude,
    //           'longitude': longitude,
    //           'difficulty_level': difficultyLevel,
    //           'tip': tip,
    //         }),
    //       )
    //       .timeout(const Duration(seconds: 15)),
    // );

    // response.verificarStatus();
    // return CachePoint.fromJson(decodificarObjeto(response));
    final novoCache = CachePoint(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      latitude: latitude,
      longitude: longitude,
      dificultyLevel: difficultyLevel,
      qrCodeContent: "geo-cache-new",
      qrCodeImageUrl: "https://link.com/qr-new.png",
      creatorId: "user_logged",
      createdAt: DateTime.now(),
      status: CachePointStatus.active,
      tip: tip,
    );
    cacheList.add(novoCache);
    return novoCache;
  }

  // PATCH /caches/:id
  Future<CachePoint> atualizarCache({
    required String token,
    required String id,
    String? title,
    String? description,
    CachePointStatus? status,
  }) async {
    // final campos = <String, dynamic>{};
    // if (title != null) campos['title'] = title;
    // if (description != null) campos['description'] = description;
    // if (status != null) campos['status'] = status;

    // final response = await executar(
    //   () => _client
    //       .patch(
    //         ApiUris.cache(id),
    //         headers: Cabecalhos.escrita(token),
    //         body: jsonEncode(campos),
    //       )
    //       .timeout(const Duration(seconds: 10)),
    // );

    // response.verificarStatus();
    // return CachePoint.fromJson(decodificarObjeto(response));
    final index = cacheList.indexWhere((cache) => cache.id == id);
    if (index != -1) {
      final cacheAtual = cacheList[index];
      final cacheAtualizado = CachePoint(
        id: cacheAtual.id,
        title: title ?? cacheAtual.title,
        description: description ?? cacheAtual.description,
        latitude: cacheAtual.latitude,
        longitude: cacheAtual.longitude,
        dificultyLevel: cacheAtual.dificultyLevel,
        qrCodeContent: cacheAtual.qrCodeContent,
        qrCodeImageUrl: cacheAtual.qrCodeImageUrl,
        creatorId: cacheAtual.creatorId,
        createdAt: cacheAtual.createdAt,
        status: status ?? cacheAtual.status,
        tip: cacheAtual.tip,
      );
      cacheList[index] = cacheAtualizado;
      return cacheAtualizado;
    }
    throw Exception("Cache não encontrado");
  }

  // DELETE /caches/:id
  Future<void> removerCache({required String token, required String id}) async {
    // final response = await executar(
    //   () => _client
    //       .delete(ApiUris.cache(id), headers: Cabecalhos.leitura(token))
    //       .timeout(const Duration(seconds: 10)),
    // );

    // if (response.statusCode != 200 && response.statusCode != 204) {
    //   response.verificarStatus();
    // }
    cacheList.removeWhere((cache) => cache.id == id);
  }
}