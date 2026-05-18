import "package:flutter/foundation.dart";

class AddCacheNotifier extends ChangeNotifier {
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

  Future<bool> submit() async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}