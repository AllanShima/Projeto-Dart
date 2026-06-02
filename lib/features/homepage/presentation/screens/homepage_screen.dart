// lib/features/homepage/presentation/screens/homepage_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:projeto_integrador/features/homepage/presentation/widgets/homepage_adaptive.dart';
import 'package:projeto_integrador/features/homepage/presentation/screens/homepage_desktop_header.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  FilterType selectedFilter = FilterType.all;
  int selectedCacheIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<ServicoAutenticacao>();
      context.read<CacheNotifier>().carregar(
        auth.currentUser?.id ?? '',
        auth.token ?? '',
      );
    });
  }

  List<UserCacheProgress> get filteredCaches {
    final List<UserCacheProgress> globalCaches = context
        .read<CacheNotifier>()
        .userCaches;
    List<UserCacheProgress> result = globalCaches;

    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (c) =>
                c.cache.title.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    return switch (selectedFilter) {
      FilterType.found => result.where((c) => c.isFound).toList(),
      FilterType.pending => result.where((c) => !c.isFound).toList(),
      FilterType.all => result,
    };
  }

  @override
  Widget build(BuildContext context) {
    context.watch<CacheNotifier>();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: HomepageHeader(),
      ),
      backgroundColor: Colors.grey[50],
      body: HomepageAdaptive(
        filteredCaches: filteredCaches,
        selectedFilter: selectedFilter,
        searchQuery: searchQuery,
        onSearchChanged: (novoTexto) {
          setState(() => searchQuery = novoTexto);
        },
        onFilterChanged: (novoFiltro) {
          setState(() => selectedFilter = novoFiltro);
        },
      ),
    );
  }
}
