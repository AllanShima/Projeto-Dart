import 'package:sqflite/sqflite.dart';

final class CachepointDao {
  const CachepointDao(this._db);
  final Database _db;

  Future<int> insert(Map<String, dynamic> cachepoint) => _db.insert(
    'cachepoints',
    cachepoint,
    conflictAlgorithm: ConflictAlgorithm.fail,
  );

  Future<Map<String, dynamic>?> getById(int id) async {
    final rows = await _db.query(
      'cachepoints',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<Map<String, dynamic>>> getByCreator(int creatorId) => _db.query(
    'cachepoints',
    where: 'creatorId = ?',
    whereArgs: [creatorId],
    orderBy: 'createdAt DESC',
  );

  Future<List<Map<String, dynamic>>> getAll() =>
      _db.query('cachepoints', orderBy: 'createdAt DESC');

  // Busca cachepoints dentro de um raio aproximado usando bounding box
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

  Future<int> update(int id, Map<String, dynamic> data) =>
      _db.update('cachepoints', data, where: 'id = ?', whereArgs: [id]);

  Future<int> delete(int id) =>
      _db.delete('cachepoints', where: 'id = ?', whereArgs: [id]);
}
