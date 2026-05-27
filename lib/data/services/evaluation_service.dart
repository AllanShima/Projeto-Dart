import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/http/api_client.dart';

class EvaluationService {
  const EvaluationService(this._client);

  final http.Client _client;

  // GET /caches/:id/evaluations
  Future<List<Map<String, dynamic>>> listarAvaliacoes({
    required String token,
    required String cacheId,
  }) async {
    final response = await executar(
      () => _client
          .get(ApiUris.avaliacoes(cacheId), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return decodificarLista(response);
  }

  // POST /caches/:id/evaluations
  Future<Map<String, dynamic>> avaliarCache({
    required String token,
    required String cacheId,
    required int grade,
    String comment = '',
  }) async {
    final response = await executar(
      () => _client
          .post(
            ApiUris.avaliacoes(cacheId),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode({'grade': grade, 'comment': comment}),
          )
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return decodificarObjeto(response);
  }

  // POST /caches/:id/checkin
  Future<Map<String, dynamic>> realizarCheckin({
    required String token,
    required String cacheId,
    required String qrCodeContent,
  }) async {
    final response = await executar(
      () => _client
          .post(
            ApiUris.checkin(cacheId),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode({'qr_code_content': qrCodeContent}),
          )
          .timeout(const Duration(seconds: 15)),
    );

    response.verificarStatus();
    return decodificarObjeto(response);
  }
}
