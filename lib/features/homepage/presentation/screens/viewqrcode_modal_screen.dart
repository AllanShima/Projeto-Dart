import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:projeto_integrador/models/cachepoint.dart';
import 'package:projeto_integrador/features/homepage/presentation/utils/qr_downloader.dart';

class ViewQrCodeModal extends StatefulWidget {
  final CachePoint cache;
  const ViewQrCodeModal({required this.cache, super.key});

  @override
  State<ViewQrCodeModal> createState() => _ViewQrCodeModalState();
}

class _ViewQrCodeModalState extends State<ViewQrCodeModal> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isDownloading = false;

  Future<void> _downloadQrCode() async {
    setState(() => _isDownloading = true);
    try {
      final boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final fileName = 'qrcode_${widget.cache.qrCodeContent}.png';
      await downloadFile(pngBytes, fileName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR Code baixado com sucesso!'),
            backgroundColor: Color(0xFF0D47A1),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    final modalWidth = isSmallScreen
        ? double.infinity
        : isMediumScreen
        ? screenSize.width * 0.85
        : 800.0;
    final qrSize = isSmallScreen ? 200.0 : 260.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16.0 : 20.0,
        vertical: isSmallScreen ? 12.0 : 24.0,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: modalWidth,
          maxHeight: screenSize.height * 0.9,
        ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ResponsiveHeader(isSmallScreen: isSmallScreen),
                const SizedBox(height: 20),
                Center(
                  child: RepaintBoundary(
                    key: _qrKey,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12),
                      child: QrImageView(
                        data: widget.cache.qrCodeContent,
                        version: QrVersions.auto,
                        size: qrSize,
                        backgroundColor: Colors.white,
                        errorStateBuilder: (ctx, err) => SizedBox(
                          width: qrSize,
                          height: qrSize,
                          child: const Center(
                            child: Text('Erro ao gerar QR Code'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isDownloading ? null : _downloadQrCode,
                    icon: _isDownloading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.download),
                    label: Text(
                      _isDownloading ? 'Salvando...' : 'Baixar QR Code',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResponsiveHeader extends StatelessWidget {
  final bool isSmallScreen;
  const _ResponsiveHeader({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    final titleSize = isSmallScreen ? 18.0 : 20.0;
    final subtitleSize = isSmallScreen ? 13.0 : 14.0;
    final iconSize = isSmallScreen ? 24.0 : 28.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Link do QrCode',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Faça o download, imprime e compartilhe!',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: subtitleSize,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.grey),
          iconSize: iconSize,
        ),
      ],
    );
  }
}
