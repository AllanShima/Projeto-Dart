import 'package:flutter/material.dart';

import 'package:projeto_integrador/models/user.dart';

import 'package:projeto_integrador/db/dao/user_dao.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

final class AuthProvider extends ChangeNotifier {
  AuthProvider(this._userDao);

  final UserDao _userDao;

  User? _currentUser;
  AuthStatus _status = AuthStatus.initial;
  String? _error;

  User? get currentUser => _currentUser;
  AuthStatus get status => _status;
  String? get error => _error;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<bool> login(String email, String password) async {
    _error = null;
    try {
      final row = await _userDao.getByEmail(email);
      if (row == null) {
        _error = 'E-mail não encontrado';
        notifyListeners();
        return false;
      }

      if (row['password'] != password) {
        _error = 'Senha incorreta';
        notifyListeners();
        return false;
      }

      _currentUser = User.fromMap(row);
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao fazer login: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    _error = null;
    try {
      final existing = await _userDao.getByEmail(email);
      if (existing != null) {
        _error = 'E-mail já cadastrado';
        notifyListeners();
        return false;
      }

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: email.split('@').first, // nome provisório até ter campo no form
        email: email,
        createdAt: DateTime.now(),
      );

      await _userDao.insert({...user.toMap(), 'password': password});

      _currentUser = user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erro ao cadastrar: $e';
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
