import 'package:flutter/material.dart';

import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';

import 'homepage_mobile.dart';
import 'homepage_desktop.dart';

import '../screens/cache_details_screen.dart';

class HomepageAdaptive extends StatefulWidget {
  final List<GeoCache> caches;

  const HomepageAdaptive({super.key, required this.caches});

  @override
  State<HomepageAdaptive> createState() => _HomepageAdaptiveState();
}

class _HomepageAdaptiveState extends State<HomepageAdaptive> {
  FilterType selectedFilter = FilterType.all;
  int selectedCacheIndex = 0;
  String searchQuery = '';

  List<GeoCache> get filteredCaches {
    List<GeoCache> result = widget.caches;

    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (cache) =>
                cache.name.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final listaParaExibir = filteredCaches;

    if (isMobile) {
      return HomepageMobile(
        selectedFilter: selectedFilter,
        searchQuery: searchQuery,
        filteredCaches: listaParaExibir,
        onSearchChanged: (novoTexto) {
          setState(() {
            searchQuery = novoTexto;
          });
        },
        onFilterChanged: (novoFiltro) {
          setState(() {
            selectedFilter = novoFiltro;
          });
        },
        onCacheSelected: (cache) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CacheDetailScreen(cache: cache),
            ),
          );
        },
      );
    } else {
      return HomepageDesktop(
        selectedFilter: selectedFilter,
        selectedCacheIndex: selectedCacheIndex,
        searchQuery: searchQuery,
        filteredCaches: listaParaExibir,
        onSearchChanged: (novoTexto) {
          setState(() {
            searchQuery = novoTexto;
          });
        },
        onFilterChanged: (novoFiltro) {
          setState(() {
            selectedFilter = novoFiltro;
          });
        },
        onCacheSelected: (novoIndex) {
          setState(() {
            selectedCacheIndex = novoIndex;
          });
        },
      );
    }
  }
}
