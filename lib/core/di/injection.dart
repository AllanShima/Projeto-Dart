

import 'package:get_it/get_it.dart';

import '/features/homepage/presentation/providers/add_cache_notifier.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {

  sl.registerLazySingleton<AddCacheNotifier>(
    () => AddCacheNotifier(),
  );
}