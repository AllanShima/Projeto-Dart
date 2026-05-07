import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';

import 'package:projeto_integrador/features/homepage/presentation/widgets/cache_detail.dart';

class HomepageDesktop extends StatefulWidget {
  // Os dados atuais (O que ele exibe)
  final FilterType selectedFilter;
  final int selectedCacheIndex;
  final String searchQuery;
  final List<GeoCache> filteredCaches; // Passe a lista filtrada também!

  // As ações (O que ele faz quando o usuário interage)
  final Function(String) onSearchChanged;
  final Function(FilterType) onFilterChanged;
  final Function(int) onCacheSelected;

  const HomepageDesktop({
    super.key,
    required this.selectedFilter,
    required this.searchQuery,
    required this.selectedCacheIndex,
    required this.filteredCaches,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onCacheSelected,
  });

  @override
  State<HomepageDesktop> createState() => _HomepageDesktopState();
}

class _HomepageDesktopState extends State<HomepageDesktop> {

  @override
  Widget build(BuildContext context) {

    final currentCache = widget.filteredCaches.isNotEmpty && widget.selectedCacheIndex < widget.filteredCaches.length
        ? widget.filteredCaches[widget.selectedCacheIndex]
        : null;

    return Row(
      children: [
        // Painel lateral com lista de caches
        SizedBox(
          width: 350,
          child: Column(
            children: [
              // Header do painel
              // Search bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  onChanged: (value) {
                    // Chama a função passada pelo pai
                    widget.onSearchChanged(value);
                    widget.onCacheSelected(0);
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
                        selected: widget.selectedFilter == FilterType.all,
                        onSelected: (_) => widget.onFilterChanged(FilterType.all),
                      ),
                    FilterChip(
                        label: const Text('Encontrados'),
                        selected: widget.selectedFilter == FilterType.found,
                        onSelected: (_) => widget.onFilterChanged(FilterType.found),
                      ),
                    FilterChip(
                        label: const Text('Pendente'),
                        selected: widget.selectedFilter == FilterType.pending,
                        onSelected: (_) => widget.onFilterChanged(FilterType.pending),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Lista de caches
              Expanded(
                child: ListView.builder(
                  itemCount: widget.filteredCaches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.filteredCaches[index].name),
                      selected: widget.selectedCacheIndex == index,
                      onTap: () => widget.onCacheSelected(index),
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
            child: currentCache != null 
              ? CacheDetailCard(cache: currentCache) 
              : const Center(child: Text("Selecione um cache")),
          ),
        ),
      ]
    );
  }
}