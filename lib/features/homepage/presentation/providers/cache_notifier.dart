import 'package:flutter/material.dart';

import 'package:projeto_integrador/db/dao/cachepoint_dao.dart';
import 'package:projeto_integrador/db/dao/user_cache_progress_dao.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';

class CacheNotifier extends ChangeNotifier {
  CacheNotifier(this._cachepointDao, this._progressDao);

  final CachepointDao _cachepointDao;
  final UserCacheProgressDao _progressDao;

  List<UserCacheProgress> _userCaches = [];
  bool isLoading = false;
  String? erro;
  String _userId = '';

  List<UserCacheProgress> get userCaches => _userCaches;

  Future<void> carregar(String userId) async {
    _userId = userId;
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      final cachepointRows = await _cachepointDao.getAll();
      final progressRows = await _progressDao.getByUser(userId);

      // Monta um mapa de progresso para lookup rápido
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

    // Persiste no banco
    await _progressDao.upsert(
      userId: _userId,
      cachepointId: cachepointId,
      isFavorited: updated.isFavorited,
      isFound: updated.isFound,
      foundAt: updated.foundAt,
    );
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

    // Persiste no banco
    await _progressDao.upsert(
      userId: _userId,
      cachepointId: cachepointId,
      isFavorited: updated.isFavorited,
      isFound: updated.isFound,
      foundAt: updated.foundAt,
    );
  }

  void addNewCache(CachePoint cachepoint) {
    _userCaches.add(UserCacheProgress(cache: cachepoint, userId: _userId));
    notifyListeners();
  }
}
