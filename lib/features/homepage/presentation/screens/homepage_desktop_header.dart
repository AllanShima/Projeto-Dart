import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:provider/provider.dart';

import 'package:projeto_integrador/features/homepage/presentation/screens/addcache_modal_screen.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader({super.key});

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return _HomepageHeaderMobile();
    } else {
      return _HomepageHeaderDesktop();
    }
  }
}

class _HomepageHeaderDesktop extends StatelessWidget {
  const _HomepageHeaderDesktop();

  @override
  Widget build(BuildContext context) {
    context.watch<CacheNotifier>();

    // Forma correta e reativa dentro do build:
    List<UserCacheProgress> foundCaches = context
        .watch<CacheNotifier>()
        .userCaches
        .where((c) => c.isFound == true)
        .toList(); // Importante converter o Iterable de volta para List

    return AppBar(
      toolbarHeight: 80.0,
      backgroundColor: const Color.fromARGB(255, 2, 61, 138),
      elevation: 5,
      title: Row(
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 40,
            height: 40,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Importante para não quebrar na AppBar
            children: [
              const Text(
                "GeoQuest Desktop",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                "Encontre tesouros escondidos",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Badge de "Encontrados"
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.blue[100]),
              const SizedBox(width: 8),
              Text(
                '${foundCaches.length} Encontrado(s)',
                style: TextStyle(color: Colors.blue[100], fontSize: 14),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.blue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddCacheModal(),
            );
          },
          label: const Text("Novo cache"),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {
            context.read<ServicoAutenticacao>().logout();
            context.go('/login');
          },
          icon: const Icon(Icons.exit_to_app, color: Colors.white),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _HomepageHeaderMobile extends StatefulWidget {
  const _HomepageHeaderMobile();

  @override
  State<_HomepageHeaderMobile> createState() => _HomepageHeaderMobileState();
}

class _HomepageHeaderMobileState extends State<_HomepageHeaderMobile> {
  @override
  Widget build(BuildContext context) {
    context.watch<CacheNotifier>();

    // Forma correta e reativa dentro do build:
    List<UserCacheProgress> foundCaches = context
        .watch<CacheNotifier>()
        .userCaches
        .where((c) => c.isFound == true)
        .toList(); // Importante converter o Iterable de volta para List

    return AppBar(
      toolbarHeight: 60.0,
      backgroundColor: const Color.fromARGB(255, 2, 61, 138),
      elevation: 4,
      title: Row(
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 32,
            height: 32,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "GeoQuest",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14, color: Colors.blue[100]),
                const SizedBox(width: 4),
                Text(
                  '${foundCaches.length}',
                  style: TextStyle(
                    color: Colors.blue[50],
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        Tooltip(
          message: 'Adicionar cache',
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddCacheModal(),
              );
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
            iconSize: 24,
          ),
        ),
        Tooltip(
          message: 'Sair',
          child: IconButton(
            onPressed: () {
              context.read<ServicoAutenticacao>().logout();
              context.go('/login');
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            iconSize: 24,
          ),
        ),
      ],
    );
  }
}
