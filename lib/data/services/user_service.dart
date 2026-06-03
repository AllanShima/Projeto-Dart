// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../../core/http/api_client.dart';
import '../../models/user.dart';

List<User> userMockList = [
  User(
    id: "user_logged",
    name: "Allan Shinhama",
    email: "allan@email.com",
    createdAt: DateTime.now(),
  ),
  User(
    id: "user_01",
    name: "Emanuelly",
    email: "manu@email.com",
    createdAt: DateTime.now(),
  ),
  User(
    id: "user_02",
    name: "Carlos Eduardo",
    email: "carlos@email.com",
    createdAt: DateTime.now(),
  ),
];

class UserService {
  // const UserService(this._client);

  // final http.Client _client;

  Future<({User user, String token})> registrar({
    required String name,
    required String email,
    required String password,
  }) async {
    // final response = await executar(
    //   () => _client
    //       .post(
    //         ApiUris.register(),
    //         headers: Cabecalhos.publico(),
    //         body: jsonEncode({
    //           'name': name,
    //           'email': email,
    //           'password': password,
    //         }),
    //       )
    //       .timeout(const Duration(seconds: 15)),
    // );
    // response.verificarStatus();
    // final json = decodificarObjeto(response);
    // return (
    //   user: User.fromJson(json['user'] as Map<String, dynamic>),
    //   token: json['token'] as String,
    // );
    final novoUsuario = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
    userMockList.add(novoUsuario);
    return (
      user: novoUsuario,
      token: "mocked_token_register_${novoUsuario.id}",
    );
  }

  Future<({User user, String token})> login({
    required String email,
    required String password,
  }) async {
    // final response = await executar(
    //   () => _client
    //       .post(
    //         ApiUris.login(),
    //         headers: Cabecalhos.publico(),
    //         body: jsonEncode({'email': email, 'password': password}),
    //       )
    //       .timeout(const Duration(seconds: 15)),
    // );
    // response.verificarStatus();
    // final json = decodificarObjeto(response);
    // return (
    //   user: User.fromJson(json['user'] as Map<String, dynamic>),
    //   token: json['token'] as String,
    // );
    final usuario = userMockList.firstWhere(
      (u) => u.email == email,
      orElse: () => userMockList.first,
    );
    return (
      user: usuario,
      token: "mocked_token_login_${usuario.id}",
    );
  }

  Future<User> buscarUsuario({
    required String token,
    required String id,
  }) async {
    // final response = await executar(
    //   () => _client
    //       .get(ApiUris.user(id), headers: Cabecalhos.leitura(token))
    //       .timeout(const Duration(seconds: 10)),
    // );
    // response.verificarStatus();
    // return User.fromJson(decodificarObjeto(response));
    return userMockList.firstWhere(
      (u) => u.id == id,
      orElse: () => userMockList.first,
    );
  }

  Future<User> atualizarUsuario({
    required String token,
    required String id,
    String? name,
    String? email,
    String? password,
  }) async {
    // final campos = <String, dynamic>{};
    // if (name != null) campos['name'] = name;
    // if (email != null) campos['email'] = email;
    // if (password != null) campos['password'] = password;
    // final response = await executar(
    //   () => _client
    //       .patch(
    //         ApiUris.user(id),
    //         headers: Cabecalhos.escrita(token),
    //         body: jsonEncode(campos),
    //       )
    //       .timeout(const Duration(seconds: 10)),
    // );
    // response.verificarStatus();
    // return User.fromJson(decodificarObjeto(response));
    final index = userMockList.indexWhere((u) => u.id == id);
    if (index != -1) {
      final usuarioAtual = userMockList[index];
      final usuarioAtualizado = User(
        id: usuarioAtual.id,
        name: name ?? usuarioAtual.name,
        email: email ?? usuarioAtual.email,
        createdAt: usuarioAtual.createdAt,
      );
      userMockList[index] = usuarioAtualizado;
      return usuarioAtualizado;
    }
    throw Exception("Usuário não encontrado");
  }

  Future<void> removerUsuario({
    required String token,
    required String id,
  }) async {
    // final response = await executar(
    //   () => _client
    //       .delete(ApiUris.user(id), headers: Cabecalhos.leitura(token))
    //       .timeout(const Duration(seconds: 10)),
    // );
    // if (response.statusCode != 200 && response.statusCode != 204) {
    //   response.verificarStatus();
    // }
    userMockList.removeWhere((u) => u.id == id);
  }
}