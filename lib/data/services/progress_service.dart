import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/http/api_client.dart';
import '../dtos/progress_dto.dart';

class ProgressService {
  const ProgressService(this._client);

  final http.Client _client;

  // GET /users/:userId/progress
  Future<List<ProgressDto>> listarProgresso({
    required String token,
    required String userId,
  }) async {
    final response = await executar(
      () => _client
          .get(ApiUris.progresso(userId), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return decodificarLista(response).map(ProgressDto.fromJson).toList();
  }

  // POST /caches/:cachepointId/checkin
  Future<ProgressDto> registrarCheckin({
    required String token,
    required String cachepointId,
    required String qrCodeContent,
  }) async {
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
  }

  // PATCH /users/:userId/progress/:cachepointId
  Future<ProgressDto> atualizarFavorito({
    required String token,
    required String userId,
    required String cachepointId,
    required bool isFavorited,
  }) async {
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
  }
}
