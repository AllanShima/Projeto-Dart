import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/usercache.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';

import 'package:projeto_integrador/features/homepage/presentation/widgets/homepage_adaptive.dart';
// Certifique-se de que o nome da classe dentro deste arquivo é HomepageHeader ou ajuste abaixo
import 'package:projeto_integrador/features/homepage/presentation/screens/homepage_desktop_header.dart';
import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';
// IMPORTANTE: Ajuste o caminho abaixo para onde o seu FilterType realmente está definido
import 'package:projeto_integrador/models/enums.dart';
import 'package:provider/provider.dart'; 

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  FilterType selectedFilter = FilterType.all;
  int selectedCacheIndex = 0;
  String searchQuery = '';


  List<UserCacheProgress> get filteredCaches {
    final List<UserCacheProgress> globalCaches = context.read<CacheNotifier>().userCaches;
    List<UserCacheProgress> result = globalCaches;

    // 1. Filtro por texto
    if (searchQuery.isNotEmpty) {
      result = result.where((c) => c.cache.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    switch (selectedFilter) {
      case FilterType.found:
        return result.where((c) => c.isFound == true).toList();

      case FilterType.pending:
        return result.where((c) => c.isFound == false).toList();

      case FilterType.all:
        return result;

      default:
        return result; 
    }
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
          filteredCaches: filteredCaches, // Sua lista que agora usa UserCacheProgress
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