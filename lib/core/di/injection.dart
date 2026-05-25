import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';

import '/router.dart';

import '/db/database_helper.dart';
import '/db/dao/user_dao.dart';
import '/db/dao/cachepoint_dao.dart';
import '/db/dao/evaluation_dao.dart';
import '/db/dao/user_cache_progress_dao.dart';

import '/providers/servico_autenticacao.dart';

import '/features/homepage/presentation/providers/add_cache_notifier.dart';
import '/features/homepage/presentation/providers/cache_notifier.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final db = await DatabaseHelper.instance.db;
  sl.registerSingleton<Database>(db);

  // DAOs
  sl.registerLazySingleton<UserDao>(() => UserDao(sl<Database>()));
  sl.registerLazySingleton<CachepointDao>(() => CachepointDao(sl<Database>()));
  sl.registerLazySingleton<EvaluationDao>(() => EvaluationDao(sl<Database>()));
  sl.registerLazySingleton<UserCacheProgressDao>(
    () => UserCacheProgressDao(sl<Database>()),
  );

  // Providers
  sl.registerLazySingleton<ServicoAutenticacao>(
    () => ServicoAutenticacao(sl<UserDao>()),
  );
  sl.registerLazySingleton<GoRouter>(
    () => buildRouter(sl<ServicoAutenticacao>()),
  );
  sl.registerLazySingleton<CacheNotifier>(
    () => CacheNotifier(sl<CachepointDao>(), sl<UserCacheProgressDao>()),
  );
  sl.registerLazySingleton<AddCacheNotifier>(
    () => AddCacheNotifier(sl<CachepointDao>()),
  );
}
