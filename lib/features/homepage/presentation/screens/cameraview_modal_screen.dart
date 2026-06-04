import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Importa o novo pacote
import 'package:projeto_integrador/features/homepage/domain/models/user_cache_progress.dart';
import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'package:provider/provider.dart';

class CameraViewModal extends StatefulWidget {
  final UserCacheProgress usercache;
  final CachePoint cache;
  const CameraViewModal({
    required this.usercache,
    required this.cache,
    super.key,
  });

  @override
  State<CameraViewModal> createState() => _CameraViewModalState();
}

class _CameraViewModalState extends State<CameraViewModal> {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: true,
    detectionSpeed: DetectionSpeed.normal,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<CacheNotifier>();

    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    final horizontalPadding = isSmallScreen ? 16.0 : 20.0;
    final verticalPadding = isSmallScreen ? 12.0 : 24.0;
    final modalWidth = isSmallScreen
        ? double.infinity
        : isMediumScreen
        ? screenSize.width * 0.85
        : 800.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: modalWidth,
          maxHeight: screenSize.height * 0.9,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isSmallScreen ? 20 : 30,
                10,
                isSmallScreen ? 20 : 30,
                20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Posicione o QR Code em frente à câmera',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 350,
                      width: 350,
                      color: Colors.black,
                      child: MobileScanner(
                        controller: _controller,
                        onDetect: (barcodeCapture) {
                          final List<Barcode> barcodes =
                              barcodeCapture.barcodes;
                          if (barcodes.isNotEmpty) {
                            final String? qrCodeValue = barcodes.first.rawValue;
                            if (qrCodeValue != null) {
                              _controller.stop();
                              _onQRCodeDetected(qrCodeValue);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onQRCodeDetected(String value) {
    final bool isCorrectCache = value == widget.cache.qrCodeContent;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isCorrectCache ? '✅ Cache Encontrado!' : '❌ QR Code Inválido',
        ),
        content: Text(
          isCorrectCache
              ? 'Parabéns! Você encontrou o cache "${widget.cache.title}"!'
              : 'Este QR Code não corresponde ao cache esperado.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isCorrectCache) {
                Navigator.of(context).pop();
                if (!widget.usercache.isFound) {
                  context.read<CacheNotifier>().toggleFound(widget.cache.id);
                }
              } else {
                _controller.start();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
