import 'package:flutter/material.dart';

import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';

import 'cache_list_tile_mobile.dart';

class HomepageMobile extends StatelessWidget {
  final FilterType selectedFilter;
  final String searchQuery;
  final List<UserCacheProgress> filteredCaches;
  final Function(String) onSearchChanged;
  final Function(FilterType) onFilterChanged;
  final Function(UserCacheProgress) onCacheSelected;

  const HomepageMobile({
    super.key,
    required this.selectedFilter,
    required this.searchQuery,
    required this.filteredCaches,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onCacheSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Buscar Geocaches...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),

        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: const Text('Todos'),
                  selected: selectedFilter == FilterType.all,
                  onSelected: (_) => onFilterChanged(FilterType.all),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: const Text('Encontrados'),
                  selected: selectedFilter == FilterType.found,
                  onSelected: (_) => onFilterChanged(FilterType.found),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: const Text('Pendente'),
                  selected: selectedFilter == FilterType.pending,
                  onSelected: (_) => onFilterChanged(FilterType.pending),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        Expanded(
          child: filteredCaches.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhum geocache encontrado',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filteredCaches.length,
                  itemBuilder: (context, index) {
                    final cache = filteredCaches[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: CacheListTileMobile(
                        cache: cache.cache,
                        onTap: () => onCacheSelected(cache),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
