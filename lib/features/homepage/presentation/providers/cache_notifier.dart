import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/usercache.dart';
import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';

class CacheNotifier extends ChangeNotifier {
  // Transferimos a lista mockada para cá
  final List<UserCacheProgress> _userCaches = [
    UserCacheProgress(
      cache: GeoCache(
        name: 'Parque da Cidade - Vista Panorâmica',
        type: 'Tradicional',
        distance: 1.2,
        difficulty: 2,
        terrain: 2,
        duration: 'D: 2 / T: 1.5',
        favorites: 42,
        description: 'Cache localizado próximo ao mirante com vista incrível da cidade. Leve itens para trocar',
        tip: 'Próximo ao banco de pedra!',
        latitude: -23.5505,
        longitude: -46.6333,
        badge: 'traditional',
        totalFound: 12,
        createdAt: "12/05/2024",
    ),
      userId: "teste",
      isFavorited: true,
      isFound: true,
      foundAt: DateTime.now()
    ),

    UserCacheProgress(
      cache: GeoCache(
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
        totalFound: 122,
        createdAt: "12/05/2023",
      ),
      userId: "teste",
      isFavorited: true,
      isFound: true,
      foundAt: DateTime.now()
    ),

    UserCacheProgress(
      cache: GeoCache(
        name: 'Centro Histórico',
        type: 'Micro',
        distance: 0.8,
        difficulty: 3,
        terrain: 2,
        duration: 'D: 3 / T: 2',
        favorites: 67,
        description: 'Cache em área histórica da cidade, perfeito para explorar as ruas antigas',
        tip: 'Leve uma moeda de 1 real',
        latitude: -23.5605,
        longitude: -46.6233,
        totalFound: 14,
        createdAt: "11/03/2022",
      ),
      userId: "teste",
      isFavorited: false,
      isFound: false,
      foundAt: DateTime.now()
    ),
    
    UserCacheProgress(
      cache: GeoCache(
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
        totalFound: 20,
        createdAt: "12/08/2025",
      ),
      userId: "teste",
      isFavorited: false,
      isFound: false,
      foundAt: DateTime.now()
    )
  ];
  
  List<UserCacheProgress> get userCaches => _userCaches;

  void addNewCache(GeoCache newGeoCache) {
    final newProgress = UserCacheProgress(
      cache: newGeoCache,
      userId: "teste",
      isFavorited: false,
      isFound: false,
    );

    _userCaches.add(newProgress);
    notifyListeners();
  }
}