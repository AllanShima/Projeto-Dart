import 'package:flutter/material.dart';
import 'package:projeto_integrador/core/di/injection.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:provider/provider.dart';

import 'router.dart';
import 'features/homepage/presentation/providers/add_cache_notifier.dart';

void main() async{
  await setupServiceLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<AddCacheNotifier>(
        //   create: (context) => AddCacheNotifier()
        // ),
        ChangeNotifierProvider<ServicoAutenticacao>(
          create: (context) => ServicoAutenticacao()
        ),
        ChangeNotifierProvider<CacheNotifier>(
          create: (context) => CacheNotifier()
        )
      ],
      child: MaterialApp.router(
        title: 'GeoQuest',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      )
    );
  }
}

