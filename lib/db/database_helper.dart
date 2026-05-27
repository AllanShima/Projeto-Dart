import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const _versao = 2;
  static const _nomeBanco = 'geoquest.db';

  Database? _db;

  Future<Database> get db async => _db ??= await _open();

  Future<Database> _open() async {
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dir = await getDatabasesPath();

    return openDatabase(
      p.join(dir, _nomeBanco),
      version: _versao,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, _) => db.transaction(
        (txn) => Future.wait([
          txn.execute(_sqlUsers),
          txn.execute(_sqlCachepoints),
          txn.execute(_sqlEvaluations),
          txn.execute(_sqlUserCacheProgress),
          txn.execute(_sqlMeta),
        ]),
      ),
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(_sqlMeta);
        }
      },
    );
  }

  static const _sqlUsers = '''
    CREATE TABLE users (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL,
      createdAt TEXT NOT NULL
    )
  ''';

  static const _sqlCachepoints = '''
    CREATE TABLE cachepoints (
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      difficultyLevel TEXT NOT NULL,
      qrCodeContent TEXT NOT NULL,
      qrCodeImageUrl TEXT NOT NULL,
      creatorId TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      status TEXT NOT NULL DEFAULT 'active',
      FOREIGN KEY (creatorId) REFERENCES users (id) ON DELETE CASCADE
    )
  ''';

  static const _sqlEvaluations = '''
    CREATE TABLE evaluations (
      id TEXT PRIMARY KEY,
      userId TEXT NOT NULL,
      cachepointId TEXT NOT NULL,
      grade INTEGER NOT NULL,
      comment TEXT,
      createdAt TEXT NOT NULL,
      FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
      FOREIGN KEY (cachepointId) REFERENCES cachepoints (id) ON DELETE CASCADE
    )
  ''';

  static const _sqlUserCacheProgress = '''
    CREATE TABLE user_cache_progress (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId TEXT NOT NULL,
      cachepointId TEXT NOT NULL,
      isFavorited INTEGER NOT NULL DEFAULT 0,
      isFound INTEGER NOT NULL DEFAULT 0,
      foundAt TEXT,
      FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
      FOREIGN KEY (cachepointId) REFERENCES cachepoints (id) ON DELETE CASCADE,
      UNIQUE (userId, cachepointId)
    )
  ''';

  static const _sqlMeta = '''
    CREATE TABLE meta (
      chave TEXT PRIMARY KEY,
      valor TEXT NOT NULL
    )
  ''';
}
