import 'package:flutter/material.dart';

import 'package:projeto_integrador/features/homepage/domain/models/geocache.dart';
import 'package:projeto_integrador/features/homepage/domain/models/usercache.dart';

import 'package:projeto_integrador/features/homepage/presentation/widgets/cache_detail.dart';

class CacheDetailScreen extends StatelessWidget {
  final UserCacheProgress usercache;

  const CacheDetailScreen({super.key, required this.usercache});

  @override
  Widget build(BuildContext context) {
    final GeoCache cache = usercache.cache;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 61, 138),
        elevation: 0,
        title: Text(
          cache.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(child: CacheDetailCard(usercache: usercache)),
    );
  }
}
