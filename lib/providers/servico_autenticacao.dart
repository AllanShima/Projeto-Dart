import 'package:flutter/material.dart';

class ServicoAutenticacao extends ChangeNotifier {
  bool _autenticado = false;
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