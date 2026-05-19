import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/usercache.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import 'package:provider/provider.dart';

import '../../domain/models/geocache.dart';

/// Widget auxiliar para mostrar métrica
class _MetricCard extends StatelessWidget {
  final String label;
  final Widget child;

  const _MetricCard({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

/// Widget para a card de informações detalhadas
class CacheDetailCard extends StatelessWidget {
  final UserCacheProgress usercache;

  const CacheDetailCard({
    required this.usercache,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final GeoCache cache = usercache.cache;
    bool isButtonEnabled = usercache.isFavorited;

    context.watch<CacheNotifier>();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header com mapa simulado
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 224, 224),
              image: const DecorationImage(
                image: AssetImage('assets/images/geocache_background.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 32,
                      color: Colors.blue[900],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Visualização do Mapa',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cache.latitude.toStringAsFixed(3)}, ${cache.longitude.toStringAsFixed(4)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Título e badges
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tradicional · GC001',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () => {
                        context.read<CacheNotifier>().toggleFavorite(usercache.cache.name)
                      },
                      child: Icon(Icons.favorite),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  cache.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Métricas em grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MetricCard(
                  label: 'Dificuldade',
                  child: Text('${(cache.difficulty).toString()}/5'),
                  // StarRating(rating: cache.difficulty),
                ),
                _MetricCard(
                  label: 'Terreno',
                  child: Text('${(cache.terrain).toString()}/5'),
                  // TerrainIndicator(
                  //   level: cache.terrain,
                  //   label: '',
                  // ),
                ),
                _MetricCard(
                  label: 'Distância',
                  child: Text(
                    '${cache.distance} km',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                _MetricCard(
                  label: 'Favoritos',
                  child: Text(
                    '★ ${cache.favorites}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Descrição
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cache.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Dica
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.yellow[300]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        size: 18,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Dica',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.yellow[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cache.tip,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.yellow[900],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Linha horizontal
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tamanho",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.4
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        cache.type,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data de Criação",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.4
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        cache.createdAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Encontrado por",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.4
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${(cache.totalFound).toString()} pessoas',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
  }
}