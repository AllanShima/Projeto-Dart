import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';

import 'package:projeto_integrador/features/homepage/presentation/screens/addcache_modal_screen.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader({super.key});

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  @override
  Widget build(BuildContext context) {
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
            mainAxisSize: MainAxisSize.min, // Importante para não quebrar na AppBar
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                '24 Encontrados',
                style: TextStyle(color: Colors.blue[50], fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Botão "Novo"
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton.icon( // TextButton.icon é mais simples que Row dentro de ElevatedButton
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddCacheModal(),
              );
            },
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            label: const Text(
              'Novo',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        IconButton(
          onPressed: () => {
            servicoAuth.logout(),
            context.go('/login')
          },
          icon: const Icon(Icons.exit_to_app, color: Colors.white),
        ),
        const SizedBox(width: 8), // Margem final
      ],
    );
  }
}
