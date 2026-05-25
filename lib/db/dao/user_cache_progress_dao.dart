import 'package:sqflite/sqflite.dart';

final class UserCacheProgressDao {
  const UserCacheProgressDao(this._db);
  final Database _db;

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
}
