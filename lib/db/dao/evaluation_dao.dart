import 'package:sqflite/sqflite.dart';

final class EvaluationDao {
  const EvaluationDao(this._db);
  final Database _db;

  Future<int> insert(Map<String, dynamic> evaluation) => _db.insert(
    'evaluations',
    evaluation,
    conflictAlgorithm: ConflictAlgorithm.fail,
  );

  Future<Map<String, dynamic>?> getById(int id) async {
    final rows = await _db.query(
      'evaluations',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<Map<String, dynamic>>> getByCachepoint(int cachepointId) =>
      _db.query(
        'evaluations',
        where: 'cachepointId = ?',
        whereArgs: [cachepointId],
        orderBy: 'createdAt DESC',
      );

  Future<List<Map<String, dynamic>>> getByUser(int userId) => _db.query(
    'evaluations',
    where: 'userId = ?',
    whereArgs: [userId],
    orderBy: 'createdAt DESC',
  );

  // Não deixa o usuário avaliar o mesmo cachepoint mais de uma vez
  Future<bool> hasUserEvaluated(int userId, int cachepointId) async {
    final rows = await _db.query(
      'evaluations',
      where: 'userId = ? AND cachepointId = ?',
      whereArgs: [userId, cachepointId],
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  Future<double?> getAverageGrade(int cachepointId) async {
    final result = await _db.rawQuery(
      'SELECT AVG(grade) as avg FROM evaluations WHERE cachepointId = ?',
      [cachepointId],
    );
    final avg = result.first['avg'];
    return avg == null ? null : (avg as num).toDouble();
  }

  Future<int> delete(int id) =>
      _db.delete('evaluations', where: 'id = ?', whereArgs: [id]);
}
