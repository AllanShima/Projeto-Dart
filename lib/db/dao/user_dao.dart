import 'package:sqflite/sqflite.dart';

final class UserDao {
  const UserDao(this._db);
  final Database _db;

  Future<int> insert(Map<String, dynamic> user) =>
      _db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.fail);

  Future<Map<String, dynamic>?> getById(String id) async {
    final rows = await _db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, dynamic>?> getByEmail(String email) async {
    final rows = await _db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<Map<String, dynamic>>> getAll() =>
      _db.query('users', orderBy: 'name ASC');

  Future<int> update(String id, Map<String, dynamic> data) =>
      _db.update('users', data, where: 'id = ?', whereArgs: [id]);

  Future<int> delete(String id) =>
      _db.delete('users', where: 'id = ?', whereArgs: [id]);
}
