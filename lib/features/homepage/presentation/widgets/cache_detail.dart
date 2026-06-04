import 'package:flutter/material.dart';
import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import 'package:projeto_integrador/features/homepage/presentation/screens/cameraview_modal_screen.dart';
import 'package:projeto_integrador/features/homepage/presentation/screens/viewqrcode_modal_screen.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:provider/provider.dart';

class _MetricCard extends StatelessWidget {
  final String label;
  final Widget child;
  const _MetricCard({required this.label, required this.child});

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

class CacheDetailCard extends StatelessWidget {
  final UserCacheProgress usercache;
  const CacheDetailCard({required this.usercache, super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<ServicoAutenticacao>();

    final CachePoint cache = usercache.cache;

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
                  Icon(Icons.location_on, size: 32, color: Colors.blue[900]),
                  const SizedBox(height: 8),
                  const Text(
                    'Visualização do Mapa',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${cache.latitude.toStringAsFixed(3)}, ${cache.longitude.toStringAsFixed(4)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Título e favorito
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
                        '${cache.dificultyLevel.label} · ${cache.status.label}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        context.read<CacheNotifier>().toggleFavorite(cache.id),
                    child: Icon(
                      usercache.isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: usercache.isFavorited ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                cache.title,
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

        // Botão encontrado
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CameraViewModal(usercache: usercache, cache: cache),
                  );
                },
              label: const Text("Escanear QrCode"),
              icon: const Icon(Icons.qr_code_scanner_outlined),
            ),
          ),
        ),

        // Métricas
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MetricCard(
                label: 'Dificuldade',
                child: Text('${cache.dificultyLevel.index + 1}/5'),
              ),
              _MetricCard(label: 'Status', child: Text(cache.status.label)),
              _MetricCard(
                label: 'Criado em',
                child: Text(
                  cache.createdAt.toLocal().toString().substring(0, 10),
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
        // QR Code content
        if (cache.tip != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.yellow[300]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.map, size: 18, color: Colors.yellow[800]),
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
                    cache.tip!,
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
        const SizedBox(height: 16),
        if (cache.creatorId == auth.currentUser!.id)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[300]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(Icons.qr_code, size: 18, color: Colors.blue[800]),
                      const SizedBox(width: 8),
                      Text(
                        'QrCode',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Acesse o seguinte o link do código QR para colar perto ou junto ao cache!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[900],
                          height: 1.4,
                        ),
                      ),
                      Tooltip(
                        message: cache.qrCodeContent,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ViewQrCodeModal(cache: cache),
                            );
                          },
                          icon: Icon(Icons.link, color: Colors.blue[900]),
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        // Rodapé
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dificuldade',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cache.dificultyLevel.label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data de Criação',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cache.createdAt.toLocal().toString().substring(0, 10),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cache.status.label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
