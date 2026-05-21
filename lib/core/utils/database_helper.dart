import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

final class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const _versao = 1;
  static const _nomeBanco = 'delivery.db';

  Database? _db;

  Future<Database> get db async => _db ??= await _open();

  Future<Database> _open() async {
    final dir = await getDatabasesPath();
    return openDatabase(
      p.join(dir, _nomeBanco),
      version: _versao,
      onCreate: (db, _) => db.transaction(
        (txn) => Future.wait([
          txn.execute(_sqlUsers),
          txn.execute(_sqlCachepoints),
          txn.execute(_sqlEvaluations),
        ]),
      ),
    );
  }

  static const _sqlUsers = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      createdAt DATETIME NOT NULL
    )
  ''';

// o qr code vai ser o id, um pacote vai traduzir o id na imagem e vice versa

  static const _sqlCachepoints = '''
    CREATE TABLE cachepoints (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      latitude DECIMAL(10,8) NOT NULL,
      longitude DECIMAL(11,8) NOT NULL,
      dificultyLevel INTEGER NOT NULL,
      creatorId INTEGER NOT NULL,
      createdAt DATETIME NOT NULL,
      FOREIGN KEY (creatorId) REFERENCES users (id) ON DELETE CASCADE
    )
  ''';

  static const _sqlEvaluations = '''
    CREATE TABLE evaluations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      cachepointId INTEGER NOT NULL,
      grade INTEGER NOT NULL,
      comment TEXT,
      createdAt DATETIME NOT NULL,
      FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
      FOREIGN KEY (cachepointId) REFERENCES cachepoints (id) ON DELETE CASCADE
    )
  ''';
}
