import 'package:sqflite/sqflite.dart';

final class UserCacheProgressDao {
  const UserCacheProgressDao(this._db);
  final Database _db;

  static const _metaKey = 'progress_ultima_atualizacao';
  static const _ttl = Duration(minutes: 15);

  Future<void> upsert({
    required String userId,
    required String cachepointId,
    required bool isFavorited,
    required bool isFound,
    DateTime? foundAt,
  }) => _db.insert('user_cache_progress', {
    'userId': userId,
    'cachepointId': cachepointId,
    'isFavorited': isFavorited ? 1 : 0,
    'isFound': isFound ? 1 : 0,
    'foundAt': foundAt?.toIso8601String(),
  }, conflictAlgorithm: ConflictAlgorithm.replace);

  Future<List<Map<String, dynamic>>> getByUser(String userId) => _db.query(
    'user_cache_progress',
    where: 'userId = ?',
    whereArgs: [userId],
  );

  Future<Map<String, dynamic>?> get(String userId, String cachepointId) async {
    final rows = await _db.query(
      'user_cache_progress',
      where: 'userId = ? AND cachepointId = ?',
      whereArgs: [userId, cachepointId],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> salvarTodos(
    List<Map<String, dynamic>> progressos,
    String userId,
  ) async {
    await _db.transaction((txn) async {
      await txn.delete(
        'user_cache_progress',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      for (final p in progressos) {
        await txn.insert(
          'user_cache_progress',
          p,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await txn.insert('meta', {
        'chave': _metaKey,
        'valor': DateTime.now().toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<bool> cacheLocalValido() async {
    final rows = await _db.query(
      'meta',
      where: 'chave = ?',
      whereArgs: [_metaKey],
    );
    if (rows.isEmpty) return false;
    final salvoEm = DateTime.tryParse(rows.first['valor'] as String? ?? '');
    if (salvoEm == null) return false;
    return DateTime.now().difference(salvoEm) < _ttl;
  }

  Future<void> invalidarCache() async {
    await _db.delete('meta', where: 'chave = ?', whereArgs: [_metaKey]);
  }
}
