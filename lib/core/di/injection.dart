import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:projeto_integrador/router.dart';
import 'package:projeto_integrador/data/services/cache_service.dart';
import 'package:projeto_integrador/data/services/evaluation_service.dart';
import 'package:projeto_integrador/data/services/user_service.dart';
import 'package:projeto_integrador/data/services/progress_service.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/add_cache_notifier.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Services with their required HTTP clients
  sl.registerLazySingleton<CacheService>(() => CacheService());
  sl.registerLazySingleton<EvaluationService>(() => EvaluationService());
  sl.registerLazySingleton<UserService>(() => UserService());
  sl.registerLazySingleton<ProgressService>(() => ProgressService());

  // Active registrations updated to only use services (No DAOs)
  sl.registerLazySingleton<ServicoAutenticacao>(
    () => ServicoAutenticacao(sl<UserService>()), 
  );

  sl.registerLazySingleton<GoRouter>(
    () => buildRouter(sl<ServicoAutenticacao>()),
  );

  sl.registerLazySingleton<CacheNotifier>(
    () => CacheNotifier(
      sl<CacheService>(),
      sl<ProgressService>(),
    ),
  );

  sl.registerLazySingleton<AddCacheNotifier>(
    () => AddCacheNotifier(sl<CacheService>()),
  );
}