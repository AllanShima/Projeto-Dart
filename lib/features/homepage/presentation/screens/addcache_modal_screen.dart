import 'package:flutter/material.dart';
import '../widgets/add_cache_form.dart';

class AddCacheModal extends StatelessWidget {
  const AddCacheModal({super.key});

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

                  AddCacheForm(onSuccess: () => Navigator.pop(context)),
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
                      'Adicionar um Novo Cache',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Compartilhe a localização!',
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
                  'Adicionar um Novo Cache',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Compartilhe a localização de um novo cache!',
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
