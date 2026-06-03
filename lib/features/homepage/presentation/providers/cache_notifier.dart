import 'package:flutter/material.dart';

import 'package:projeto_integrador/core/exceptions/app_exceptions.dart';
import 'package:projeto_integrador/data/services/cache_service.dart';
import 'package:projeto_integrador/data/services/progress_service.dart';
import 'package:projeto_integrador/db/dao/cachepoint_dao.dart';
import 'package:projeto_integrador/db/dao/user_cache_progress_dao.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';

class CacheNotifier extends ChangeNotifier {
  CacheNotifier(
    // this._cachepointDao,
    // this._progressDao,
    this._cacheService,
    this._progressService,
  );

  // final CachepointDao _cachepointDao;
  // final UserCacheProgressDao _progressDao;
  final CacheService _cacheService;
  final ProgressService _progressService;

  List<UserCacheProgress> _userCaches = [];
  bool isLoading = false;
  String? erro;
  String _userId = '';
  String _token = '';

  List<UserCacheProgress> get userCaches => _userCaches;

  Future<void> carregar(
    String userId,
    String token, {
    double? lat,
    double? lng,
    double raioKm = 10,
  }) async {
    _userId = userId;
    _token = token;
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      /*
      List<Map<String, dynamic>> cachepointRows;

      if (await _cachepointDao.cacheLocalValido()) {
        cachepointRows = await _cachepointDao.getAll();
      } else {
        final remotos = await _cacheService.listarCaches(
          token: _token,
          lat: lat,
          lng: lng,
          raioKm: raioKm,
        );
        await _cachepointDao.salvarTodos(
          remotos.map((cp) => cp.toMap()).toList(),
        );
        cachepointRows = remotos.map((cp) => cp.toMap()).toList();
      }

      try {
        final remotos = await _progressService.listarProgresso(
          token: _token,
          userId: _userId,
        );
        await _progressDao.salvarTodos(
          remotos.map((p) => p.toMap()).toList(),
          _userId,
        );
      } on NetworkException {
        // sem conexão: usa o que está no SQLite
      }

      final progressRows = await _progressDao.getByUser(userId);
      final progressMap = {
        for (final row in progressRows) row['cachepointId'] as String: row,
      };

      _userCaches = cachepointRows.map((row) {
        final cachepoint = CachePoint.fromMap(row);
        final progress = progressMap[cachepoint.id];
        return UserCacheProgress(
          cache: cachepoint,
          userId: userId,
          isFavorited: progress?['isFavorited'] == 1,
          isFound: progress?['isFound'] == 1,
          foundAt: progress?['foundAt'] != null
              ? DateTime.parse(progress!['foundAt'] as String)
              : null,
        );
      }).toList();
      */

      final remotosCaches = await _cacheService.listarCaches(
        token: _token,
        lat: lat,
        lng: lng,
        raioKm: raioKm,
      );

      final remotosProgresso = await _progressService.listarProgresso(
        token: _token,
        userId: _userId,
      );

      final progressMap = {
        for (final p in remotosProgresso) p.cachepointId: p,
      };

      _userCaches = remotosCaches.map((cachepoint) {
        final progress = progressMap[cachepoint.id];
        return UserCacheProgress(
          cache: cachepoint,
          userId: userId,
          isFavorited: progress?.isFavorited ?? false,
          isFound: progress?.isFound ?? false,
          foundAt: progress?.foundAt,
        );
      }).toList();
    } on AppException catch (e) {
      erro = e.mensagem;
    } catch (e) {
      erro = 'Erro ao carregar caches: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String cachepointId) async {
    final index = _userCaches.indexWhere((c) => c.cache.id == cachepointId);
    if (index == -1) return;

    final updated = _userCaches[index].copyWith(
      isFavorited: !_userCaches[index].isFavorited,
    );
    _userCaches[index] = updated;
    notifyListeners();

    /*
    await _progressDao.upsert(
      userId: _userId,
      cachepointId: cachepointId,
      isFavorited: updated.isFavorited,
      isFound: updated.isFound,
      foundAt: updated.foundAt,
    );
    */

    try {
      await _progressService.atualizarFavorito(
        token: _token,
        userId: _userId,
        cachepointId: cachepointId,
        isFavorited: updated.isFavorited,
      );
    } on AppException {
      // falha de rede ou API: dado já está salvo localmente
    }
  }

  Future<void> toggleFound(String cachepointId) async {
    final index = _userCaches.indexWhere((c) => c.cache.id == cachepointId);
    if (index == -1) return;

    final newIsFound = !_userCaches[index].isFound;
    final updated = _userCaches[index].copyWith(
      isFound: newIsFound,
      foundAt: newIsFound ? DateTime.now() : null,
    );
    _userCaches[index] = updated;
    notifyListeners();

    /*
    await _progressDao.upsert(
      userId: _userId,
      cachepointId: cachepointId,
      isFavorited: updated.isFavorited,
      isFound: updated.isFound,
      foundAt: updated.foundAt,
    );
    */

    if (newIsFound) {
      try {
        await _progressService.registrarCheckin(
          token: _token,
          cachepointId: cachepointId,
          qrCodeContent: updated.cache.qrCodeContent,
        );
      } on AppException {
        // falha silenciosa: checkin local já registrado
      }
    }
  }

  Future<void> addNewCache(CachePoint cachepoint) async {
    /*
    await _cachepointDao.insert(cachepoint.toMap());
    await _cachepointDao.invalidarCache();
    */
    _userCaches.add(UserCacheProgress(cache: cachepoint, userId: _userId));
    notifyListeners();
  }
}