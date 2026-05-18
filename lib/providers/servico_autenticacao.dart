import 'package:flutter/material.dart';

class ServicoAutenticacao extends ChangeNotifier {
  // String? _email;
  bool _autenticado = false;

  // String? get email => _email;
  bool get autenticado => _autenticado;

  void login() {
    _autenticado = true;
    notifyListeners();
  }

  void logout() {
    _autenticado = false;
    notifyListeners();
  }
}