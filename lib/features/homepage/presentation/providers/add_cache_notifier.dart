import 'package:flutter/foundation.dart';

import 'package:projeto_integrador/db/dao/cachepoint_dao.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'package:projeto_integrador/models/enums.dart';

class AddCacheNotifier extends ChangeNotifier {
  AddCacheNotifier(this._dao);

  final CachepointDao _dao;

  String? cacheType;
  String? cacheSize;
  int difficulty = 1;
  int terrain = 1;
  bool hasHint = false;
  bool isLoading = false;

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

  Future<bool> submit({
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String creatorId,
    String? tip,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final cachepoint = CachePoint(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        latitude: latitude,
        longitude: longitude,
        dificultyLevel: DificultyLevel.fromString(
          _difficultyToString(difficulty),
        ),
        qrCodeContent: DateTime.now().millisecondsSinceEpoch.toString(),
        qrCodeImageUrl: '',
        creatorId: creatorId,
        createdAt: DateTime.now(),
      );

      await _dao.insert(cachepoint.toMap());
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String _difficultyToString(int value) {
    switch (value) {
      case 1:
        return 'easy';
      case 2:
        return 'medium';
      case 3:
        return 'hard';
      default:
        return 'extreme';
    }
  }
}
