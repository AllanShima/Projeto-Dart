import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/http/api_client.dart';
import '../../models/user.dart';

class UserService {
  const UserService(this._client);

  final http.Client _client;

  Future<({User user, String token})> registrar({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await executar(
      () => _client
          .post(
            ApiUris.register(),
            headers: Cabecalhos.publico(),
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 15)),
    );

    response.verificarStatus();
    final json = decodificarObjeto(response);
    return (
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }

  // POST /auth/login
  Future<({User user, String token})> login({
    required String email,
    required String password,
  }) async {
    final response = await executar(
      () => _client
          .post(
            ApiUris.login(),
            headers: Cabecalhos.publico(),
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 15)),
    );

    response.verificarStatus();
    final json = decodificarObjeto(response);
    return (
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }

  // GET /users/:id
  Future<User> buscarUsuario({
    required String token,
    required String id,
  }) async {
    final response = await executar(
      () => _client
          .get(ApiUris.user(id), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return User.fromJson(decodificarObjeto(response));
  }

  // PATCH /users/:id
  Future<User> atualizarUsuario({
    required String token,
    required String id,
    String? name,
    String? email,
    String? password,
  }) async {
    final campos = <String, dynamic>{};
    if (name != null) campos['name'] = name;
    if (email != null) campos['email'] = email;
    if (password != null) campos['password'] = password;

    final response = await executar(
      () => _client
          .patch(
            ApiUris.user(id),
            headers: Cabecalhos.escrita(token),
            body: jsonEncode(campos),
          )
          .timeout(const Duration(seconds: 10)),
    );

    response.verificarStatus();
    return User.fromJson(decodificarObjeto(response));
  }

  // DELETE /users/:id
  Future<void> removerUsuario({
    required String token,
    required String id,
  }) async {
    final response = await executar(
      () => _client
          .delete(ApiUris.user(id), headers: Cabecalhos.leitura(token))
          .timeout(const Duration(seconds: 10)),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      response.verificarStatus();
    }
  }
}
