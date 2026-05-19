import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';

import 'package:projeto_integrador/features/homepage/domain/models/usercache.dart';

import 'homepage_mobile.dart';
import 'homepage_desktop.dart';

import '../screens/cache_details_screen.dart';

class HomepageAdaptive extends StatefulWidget {
  final List<UserCacheProgress> filteredCaches; // Corrigido: adicionado ';'
  final FilterType selectedFilter;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<FilterType> onFilterChanged;

  const HomepageAdaptive({
    super.key,
    required this.filteredCaches,
    required this.selectedFilter,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  @override
  State<HomepageAdaptive> createState() => _HomepageAdaptiveState();
}

class _HomepageAdaptiveState extends State<HomepageAdaptive> {
  // O index do cache selecionado faz sentido ficar aqui se for usado apenas no layout Desktop
  int selectedCacheIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    // Corrigido: Usando 'widget.' para acessar a propriedade do StatefulWidget
    final listaParaExibir = widget.filteredCaches; 

    if (isMobile) {
      return HomepageMobile(
        selectedFilter: widget.selectedFilter,
        searchQuery: widget.searchQuery,
        filteredCaches: listaParaExibir,
        onSearchChanged: widget.onSearchChanged,
        onFilterChanged: widget.onFilterChanged,
        onCacheSelected: (cache) {
          Navigator.of(context).push(
            MaterialPageRoute(
              // Supondo que seu UserCacheProgress tenha o objeto de cache dentro:
              builder: (context) => CacheDetailScreen(usercache: cache), 
            ),
          );
        },
      );
    } else {
      return HomepageDesktop(
        selectedFilter: widget.selectedFilter,
        selectedCacheIndex: selectedCacheIndex,
        searchQuery: widget.searchQuery,
        filteredCaches: listaParaExibir,
        onSearchChanged: widget.onSearchChanged,
        onFilterChanged: widget.onFilterChanged,
        onCacheSelected: (novoIndex) {
          setState(() {
            selectedCacheIndex = novoIndex;
          });
        },
      );
    }
  }
}