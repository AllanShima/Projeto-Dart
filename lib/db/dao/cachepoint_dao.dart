import 'package:sqflite/sqflite.dart';

final class CachepointDao {
  const CachepointDao(this._db);
  final Database _db;

  Future<int> insert(Map<String, dynamic> cachepoint) => _db.insert(
    'cachepoints',
    cachepoint,
    conflictAlgorithm: ConflictAlgorithm.fail,
  );

  Future<Map<String, dynamic>?> getById(String id) async {
    final rows = await _db.query(
      'cachepoints',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<Map<String, dynamic>>> getByCreator(String creatorId) =>
      _db.query(
        'cachepoints',
        where: 'creatorId = ?',
        whereArgs: [creatorId],
        orderBy: 'createdAt DESC',
      );

  Future<List<Map<String, dynamic>>> getAll() =>
      _db.query('cachepoints', orderBy: 'createdAt DESC');

  Future<List<Map<String, dynamic>>> getByBoundingBox({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) => _db.query(
    'cachepoints',
    where: 'latitude BETWEEN ? AND ? AND longitude BETWEEN ? AND ?',
    whereArgs: [minLat, maxLat, minLng, maxLng],
    orderBy: 'createdAt DESC',
  );

  Future<int> update(String id, Map<String, dynamic> data) =>
      _db.update('cachepoints', data, where: 'id = ?', whereArgs: [id]);

  Future<int> delete(String id) =>
      _db.delete('cachepoints', where: 'id = ?', whereArgs: [id]);

  static const _metaKey = 'cachepoints_ultima_atualizacao';
  static const _ttl = Duration(minutes: 15);

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

  Future<void> salvarTodos(List<Map<String, dynamic>> cachepoints) async {
    await _db.transaction((txn) async {
      await txn.delete('cachepoints');
      for (final cp in cachepoints) {
        await txn.insert(
          'cachepoints',
          cp,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await txn.insert('meta', {
        'chave': _metaKey,
        'valor': DateTime.now().toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<void> invalidarCache() async {
    await _db.delete('meta', where: 'chave = ?', whereArgs: [_metaKey]);
  }
}
