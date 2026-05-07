import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/presentation/screens/homepage_desktop_header.dart';
import 'package:projeto_integrador/features/homepage/presentation/screens/homepage_desktop.dart';

import '../../../homepage/presentation/screens/addcache_modal_screen.dart';
import '../../domain/models/geocache.dart';
import '../widgets/cache_detail.dart';
import '../widgets/cache_list_item.dart';

// ============= SCREEN PRINCIPAL =============
class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  FilterType selectedFilter = FilterType.all;
  int selectedCacheIndex = 0;
  String searchQuery = '';

  final List<GeoCache> caches = [
    GeoCache(
      name: 'Parque da Cidade - Vista Panorâmica',
      type: 'Tradicional',
      distance: 1.2,
      difficulty: 2,
      terrain: 2,
      duration: 'D: 2 / T: 1.5',
      favorites: 42,
      description:
          'Cache localizado próximo ao mirante com vista incrível da cidade. Leve itens para trocar',
      tip: 'Próximo ao banco de pedra!',
      latitude: -23.5505,
      longitude: -46.6333,
      badge: 'traditional',
    ),
    GeoCache(
      name: 'Trilha da Cachoeira',
      type: 'Pequeno',
      distance: 3.8,
      difficulty: 3,
      terrain: 4,
      duration: 'D: 3.5 / T: 4',
      favorites: 89,
      description: 'Cache escondido em trilha de dificuldade média com bela paisagem',
      tip: 'Cuidado com pedras soltas na trilha',
      latitude: -23.4405,
      longitude: -46.6833,
    ),
    GeoCache(
      name: 'Centro Histórico',
      type: 'Micro',
      distance: 0.8,
      difficulty: 3,
      terrain: 2,
      duration: 'D: 3 / T: 2',
      favorites: 67,
      description:
          'Cache em área histórica da cidade, perfeito para explorar as ruas antigas',
      tip: 'Leve uma moeda de 1 real',
      latitude: -23.5605,
      longitude: -46.6233,
    ),
    GeoCache(
      name: 'Praça das Artes',
      type: 'Pequeno',
      distance: 2.1,
      difficulty: 1,
      terrain: 1,
      duration: 'D: 1.5 / T: 1',
      favorites: 31,
      description: 'Cache fácil em praça com vida cultural intensa',
      tip: 'Próximo ao palco do lado direito',
      latitude: -23.5705,
      longitude: -46.6433,
    ),
  ];

  List<GeoCache> get filteredCaches {
    List<GeoCache> result = caches;

    if (searchQuery.isNotEmpty) {
      result = result
          .where((cache) =>
              cache.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {

    // Pegamos a lista filtrada uma vez para usar no widget abaixo
    final listaParaExibir = filteredCaches;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Defina a altura que você deseja
          child: const HomepageHeader(),
        ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Expanded(
            child: HomepageDesktop(
              selectedFilter: selectedFilter, // Sem o "widget."
              selectedCacheIndex: selectedCacheIndex,
              searchQuery: searchQuery,
              filteredCaches: listaParaExibir, // Usa o getter filteredCaches
            
              onSearchChanged: (novoTexto) {
                setState(() {
                  searchQuery = novoTexto; // Nome corrigido
                });
              },
              onFilterChanged: (novoFiltro) {
                setState(() {
                  selectedFilter = novoFiltro; // Nome corrigido
                });
              },
              onCacheSelected: (novoIndex) {
                setState(() {
                  selectedCacheIndex = novoIndex; // Nome corrigido
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

// ============= MAIN =============
// void main() {
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GeoQuest',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const HomepageScreen(),
//     );
//   }
// }