// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../../core/http/api_client.dart';
import '../dtos/progress_dto.dart';

class ProgressService {
  // const ProgressService(this._client);
  // ProgressService(this._client);

  // final http.Client _client;

  static final List<ProgressDto> _mockProgressList = [
    ProgressDto.fromJson({
      'user_id': 'user_101',
      'cachepoint_id': 'cache_1',
      'is_favorited': true,
      'is_found': true,
      'found_at': '2026-05-20T14:30:00Z',
    }),
    ProgressDto.fromJson({
      'user_id': 'user_101',
      'cachepoint_id': 'cache_2',
      'is_favorited': false,
      'is_found': false,
      'found_at': null,
    }),
  ];

  // GET /users/:userId/progress
  Future<List<ProgressDto>> listarProgresso({
    required String token,
    required String userId,
  }) async {
    /*
    final response = await executar(
      () => _client
          .get(ApiUris.progresso(userId), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return decodificarLista(response).map(ProgressDto.fromJson).toList();
    */
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProgressList;
  }

  // POST /caches/:cachepointId/checkin
  Future<ProgressDto> registrarCheckin({
    required String token,
    required String cachepointId,
    required String qrCodeContent,
  }) async {
    /*
    final response = await executar(
      () => _client
          .post(
            ApiUris.checkin(cachepointId),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode({'qr_code_content': qrCodeContent}),
          )
          .timeout(const Duration(seconds: 15)),
    );

    response.verificarStatus();
    return ProgressDto.fromJson(decodificarObjeto(response));
    */
    await Future.delayed(const Duration(milliseconds: 800));

    if (qrCodeContent.isEmpty) {
      throw Exception('QR Code inválido');
    }

    try {
      final existingIndex = _mockProgressList.indexWhere((p) => p.cachepointId == cachepointId);
      final updatedJson = {
        'user_id': 'user_101',
        'cachepoint_id': cachepointId,
        'is_favorited': existingIndex != -1 ? _mockProgressList[existingIndex].isFavorited : false,
        'is_found': true,
        'found_at': DateTime.now().toIso8601String(),
      };

      final updatedProgress = ProgressDto.fromJson(updatedJson);

      if (existingIndex != -1) {
        _mockProgressList[existingIndex] = updatedProgress;
      } else {
        _mockProgressList.add(updatedProgress);
      }

      return updatedProgress;
    } catch (_) {
      return ProgressDto.fromJson({
        'user_id': 'user_101',
        'cachepoint_id': cachepointId,
        'is_favorited': false,
        'is_found': true,
        'found_at': DateTime.now().toIso8601String(),
      });
    }
  }

  // PATCH /users/:userId/progress/:cachepointId
  Future<ProgressDto> atualizarFavorito({
    required String token,
    required String userId,
    required String cachepointId,
    required bool isFavorited,
  }) async {
    /*
    final response = await executar(
      () => _client
          .patch(
            ApiUris.progressoItem(userId, cachepointId),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode({'is_favorited': isFavorited}),
          )
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return ProgressDto.fromJson(decodificarObjeto(response));
    */
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _mockProgressList.indexWhere((p) => p.cachepointId == cachepointId);

    try {
      final updatedJson = {
        'user_id': userId,
        'cachepoint_id': cachepointId,
        'is_favorited': isFavorited,
        'is_found': index != -1 ? _mockProgressList[index].isFound : false,
        'found_at': index != -1 ? _mockProgressList[index].foundAt?.toIso8601String() : null,
      };

      final updatedProgress = ProgressDto.fromJson(updatedJson);

      if (index != -1) {
        _mockProgressList[index] = updatedProgress;
      } else {
        _mockProgressList.add(updatedProgress);
      }

      return updatedProgress;
    } catch (_) {
      return ProgressDto.fromJson({
        'user_id': userId,
        'cachepoint_id': cachepointId,
        'is_favorited': isFavorited,
        'is_found': false,
        'found_at': null,
      });
    }
  }
}