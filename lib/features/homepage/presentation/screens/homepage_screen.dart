import 'package:flutter/material.dart';

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
    final currentCache = filteredCaches.isNotEmpty
        ? filteredCaches[
            selectedCacheIndex.clamp(0, filteredCaches.length - 1)]
        : caches[0];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Painel lateral com lista de caches
          SizedBox(
            width: 300,
            child: Column(
              children: [
                // Header do painel
                Container(
                  color: Colors.blue[900],
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'GeoQuest Desktop',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Encontre tesouros escondidos',
                                style: TextStyle(
                                  color: Colors.blue[100],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 16,
                                    color: Colors.blue[100],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '24 Encontrados',
                                    style: TextStyle(
                                      color: Colors.blue[50],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => const AddCacheModal()
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.blue[50],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Novo',
                                    style: TextStyle(
                                      color: Colors.blue[50],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        selectedCacheIndex = 0;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar Geocaches...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                // Filtros
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterChip(
                        label: const Text('Todos'),
                        selected: selectedFilter == FilterType.all,
                        onSelected: (bool selected) {
                          setState(() => selectedFilter = FilterType.all);
                        },
                      ),
                      FilterChip(
                        label: const Text('Encontrados'),
                        selected: selectedFilter == FilterType.found,
                        onSelected: (bool selected) {
                          setState(() => selectedFilter = FilterType.found);
                        },
                      ),
                      FilterChip(
                        label: const Text('Pendente'),
                        selected: selectedFilter == FilterType.pending,
                        onSelected: (bool selected) {
                          setState(() => selectedFilter = FilterType.pending);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Lista de caches
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCaches.length,
                    itemBuilder: (context, index) {
                      return CacheListItem(
                        cache: filteredCaches[index],
                        isSelected: selectedCacheIndex == index,
                        onTap: () {
                          setState(() => selectedCacheIndex = index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Painel direito com detalhes
          Expanded(
            child: Container(
              color: Colors.white,
              child: CacheDetailCard(cache: currentCache),
            ),
          ),
        ],
      ),
    );
  }
}

// ============= MAIN =============
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoQuest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomepageScreen(),
    );
  }
}