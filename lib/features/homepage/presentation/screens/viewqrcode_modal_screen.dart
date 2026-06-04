import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_integrador/models/cachepoint.dart';

class ViewQrCodeModal extends StatelessWidget {
  final CachePoint cache;
  const ViewQrCodeModal({required this.cache, super.key});

  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ResponsiveHeader(isSmallScreen: isSmallScreen),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cache.qrCodeContent,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        )
                      ),
                      const SizedBox(width: 16),// Required for Clipboard

                        // ... inside your widget tree ...

                        GestureDetector(
                          onTap: () async {
                            // 1. Copy the text to the system clipboard
                            await Clipboard.setData(ClipboardData(text: cache.qrCodeImageUrl));
                            
                            // 2. Optional: Show a small toast/snackbar confirmation to the user
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Link copied to clipboard!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(
                            cache.qrCodeImageUrl,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                              decoration: TextDecoration.underline, // Optional: gives a visual cue it's a link
                            ),
                          ),
                        )
                    ],
                  ),
                  Center(child: Image.network(cache.qrCodeImageUrl)),
                ],
              ),
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
    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Link do QrCode',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Faça o download, imprime e compartilhe!',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.grey),
                iconSize: 24,
              ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Link do QrCode',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Faça o download, imprime e compartilhe!',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.grey),
            iconSize: 28,
          ),
        ],
      );
    }
  }
}
