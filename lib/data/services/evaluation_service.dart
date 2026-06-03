// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../../core/http/api_client.dart';

class EvaluationService {
  // const EvaluationService(this._client);
  // EvaluationService(this._client);

  // final http.Client _client;

  static final List<Map<String, dynamic>> _mockEvaluations = [
    {
      'id': 'eval_1',
      'cacheId': 'cache_1',
      'userId': 'user_101',
      'userName': 'Carlos Silva',
      'grade': 5,
      'comment': 'Excelente localização e contêiner muito bem escondido!',
      'createdAt': '2026-05-20T14:30:00Z',
    },
    {
      'id': 'eval_2',
      'cacheId': 'cache_1',
      'userId': 'user_102',
      'userName': 'Ana Souza',
      'grade': 4,
      'comment': 'Muito bom, mas o mosquito castigou um pouco na mata.',
      'createdAt': '2026-06-01T10:15:00Z',
    },
    {
      'id': 'eval_3',
      'cacheId': 'cache_2',
      'userId': 'user_103',
      'userName': 'Marcos Lima',
      'grade': 3,
      'comment': 'Logbook estava um pouco molhado.',
      'createdAt': '2026-05-28T18:00:00Z',
    },
  ];

  // GET /caches/:id/evaluations
  Future<List<Map<String, dynamic>>> listarAvaliacoes({
    required String token,
    required String cacheId,
  }) async {
    /*
    final response = await executar(
      () => _client
          .get(ApiUris.avaliacoes(cacheId), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return decodificarLista(response);
    */
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockEvaluations.where((e) => e['cacheId'] == cacheId).toList();
  }

  // POST /caches/:id/evaluations
  Future<Map<String, dynamic>> avaliarCache({
    required String token,
    required String cacheId,
    required int grade,
    String comment = '',
  }) async {
    /*
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
    */
    await Future.delayed(const Duration(milliseconds: 500));

    final novaAvaliacao = {
      'id': 'eval_${DateTime.now().millisecondsSinceEpoch}',
      'cacheId': cacheId,
      'userId': 'user_mocked',
      'userName': 'Usuário Teste',
      'grade': grade,
      'comment': comment,
      'createdAt': DateTime.now().toIso8601String(),
    };

    _mockEvaluations.add(novaAvaliacao);
    return novaAvaliacao;
  }

  // POST /caches/:id/checkin
  Future<Map<String, dynamic>> realizarCheckin({
    required String token,
    required String cacheId,
    required String qrCodeContent,
  }) async {
    /*
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
    */
    await Future.delayed(const Duration(milliseconds: 800));

    if (qrCodeContent.isEmpty) {
      throw Exception('QR Code inválido ou vazio');
    }

    return {
      'status': 'success',
      'message': 'Check-in realizado com sucesso!',
      'cacheId': cacheId,
      'checkinAt': DateTime.now().toIso8601String(),
      'pointsEarned': 100,
    };
  }
}