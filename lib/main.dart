import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/add_cache_notifier.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServicoAutenticacao>.value(
          value: sl<ServicoAutenticacao>(),
        ),
        ChangeNotifierProvider<CacheNotifier>.value(value: sl<CacheNotifier>()),
        ChangeNotifierProvider<AddCacheNotifier>.value(
          value: sl<AddCacheNotifier>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'GeoQuest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: sl<GoRouter>(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
