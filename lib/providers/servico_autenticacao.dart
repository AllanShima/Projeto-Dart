import 'package:flutter/material.dart';

import '../../core/exceptions/app_exceptions.dart';
import '../../data/services/user_service.dart';
import '../../db/dao/user_dao.dart';
import '../../models/user.dart';

class ServicoAutenticacao extends ChangeNotifier {
  ServicoAutenticacao(this._userDao, this._userService);

  final UserDao _userDao;
  final UserService _userService;

  User? _currentUser;
  bool _autenticado = false;
  String? _erro;
  String? _token;

  bool get autenticado => _autenticado;
  User? get currentUser => _currentUser;
  String? get erro => _erro;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    _erro = null;
    try {
      final result = await _userService.login(email: email, password: password);

      _currentUser = result.user;
      _token = result.token;
      _autenticado = true;

      // Persiste localmente para acesso offline
      try {
        await _userDao.insert({...result.user.toMap(), 'password': password});
      } catch (_) {
        await _userDao.update(result.user.id, result.user.toMap());
      }

      notifyListeners();
      return true;
    } on UnauthorizedException {
      _erro = 'E-mail ou senha incorretos.';
      notifyListeners();
      return false;
    } on NetworkException {
      // Fallback local se sem conexão
      return _loginLocal(email, password);
    } on AppException catch (e) {
      _erro = e.mensagem;
      notifyListeners();
      return false;
    } catch (e) {
      _erro = 'Erro ao fazer login: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> _loginLocal(String email, String password) async {
    try {
      final row = await _userDao.getByEmail(email);
      if (row == null) {
        _erro = 'E-mail não encontrado.';
        notifyListeners();
        return false;
      }
      if (row['password'] != password) {
        _erro = 'Senha incorreta.';
        notifyListeners();
        return false;
      }
      _currentUser = User.fromMap(row);
      _autenticado = true;
      _token = 'offline_token_${_currentUser!.id}';
      notifyListeners();
      return true;
    } catch (e) {
      _erro = 'Erro ao fazer login offline: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    _erro = null;
    try {
      final result = await _userService.registrar(
        name: name,
        email: email,
        password: password,
      );

      _currentUser = result.user;
      _token = result.token;
      _autenticado = true;

      await _userDao.insert({...result.user.toMap(), 'password': password});

      notifyListeners();
      return true;
    } on ConflictException {
      _erro = 'E-mail já cadastrado.';
      notifyListeners();
      return false;
    } on AppException catch (e) {
      _erro = e.mensagem;
      notifyListeners();
      return false;
    } catch (e) {
      _erro = 'Erro ao cadastrar: $e';
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _autenticado = false;
    _token = null;
    notifyListeners();
  }
}
