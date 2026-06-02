import 'package:flutter/foundation.dart';

import 'package:projeto_integrador/core/exceptions/app_exceptions.dart';
import 'package:projeto_integrador/data/services/cache_service.dart';
import 'package:projeto_integrador/db/dao/cachepoint_dao.dart';
import 'package:projeto_integrador/models/cachepoint.dart';

class AddCacheNotifier extends ChangeNotifier {
  AddCacheNotifier(this._dao, this._cacheService);

  final CachepointDao _dao;
  final CacheService _cacheService;

  String? cacheType;
  String? cacheSize;
  int difficulty = 1;
  int terrain = 1;
  bool hasHint = false;
  bool isLoading = false;
  String? erro;

  void setCacheType(String? value) {
    cacheType = value;
    notifyListeners();
  }

  void setCacheSize(String? value) {
    cacheSize = value;
    notifyListeners();
  }

  void setDifficulty(int value) {
    difficulty = value;
    notifyListeners();
  }

  void setTerrain(int value) {
    terrain = value;
    notifyListeners();
  }

  void toggleHint(bool value) {
    hasHint = value;
    notifyListeners();
  }

  Future<CachePoint?> submit({
    required String token,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String creatorId,
    String? tip,
  }) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      final cachepoint = await _cacheService.criarCache(
        token: token,
        title: title,
        description: description,
        latitude: latitude,
        longitude: longitude,
        difficultyLevel: _difficultyToString(difficulty),
        tip: tip,
      );

      await _dao.insert(cachepoint.toMap());
      await _dao.invalidarCache();

      return cachepoint;
    } on AppException catch (e) {
      erro = e.mensagem;
      return null;
    } catch (e) {
      erro = 'Erro inesperado ao criar cache.';
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String _difficultyToString(int value) {
    return switch (value) {
      1 => 'easy',
      2 => 'medium',
      3 => 'hard',
      _ => 'extreme',
    };
  }
}
