import 'package:flutter/material.dart';
import 'package:projeto_integrador/providers/servico_autenticacao.dart';
import 'package:provider/provider.dart';

import 'package:projeto_integrador/features/homepage/presentation/providers/cache_notifier.dart';
import '../providers/add_cache_notifier.dart';
import '../validators/cache.dart';

import 'labeled_dropdown.dart';
import 'rating_selector.dart';

class AddCacheForm extends StatefulWidget {
  final VoidCallback onSuccess;

  const AddCacheForm({super.key, required this.onSuccess});

  @override
  State<AddCacheForm> createState() => _AddCacheFormState();
}

class _AddCacheFormState extends State<AddCacheForm> {
  final _formKey = GlobalKey<FormState>();

  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _hintController = TextEditingController();

  final _descriptionFocus = FocusNode();
  final _hintFocus = FocusNode();

  static const _cacheTypes = ['Tradicional', 'Mistério', 'Multi'];
  static const _cacheSizes = ['Micro', 'Pequeno', 'Regular', 'Grande'];

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    _hintController.dispose();
    _descriptionFocus.dispose();
    _hintFocus.dispose();
    super.dispose();
  }

  Future<void> _submit(AddCacheNotifier formNotifier) async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final auth = context.read<ServicoAutenticacao>();

    final ok = await formNotifier.submit(
      title: _addressController.text,
      description: _descriptionController.text,
      latitude: -23.5505, // mockado até integrar mapa
      longitude: -46.6333,
      creatorId: auth.currentUser?.id ?? '',
      tip: formNotifier.hasHint ? _hintController.text : null,
    );

    if (!mounted) return;

    if (ok) {
      // Recarrega a lista após adicionar
      final authUser = context.read<ServicoAutenticacao>().currentUser;
      await context.read<CacheNotifier>().carregar(authUser?.id ?? '');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 12),
              Text('Cache criado com sucesso!'),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
      widget.onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao criar cache.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AddCacheNotifier>();

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _addressController,
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.next,
            validator: CacheValidators.address,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
            decoration: InputDecoration(
              hintText: 'Buscar Endereço...',
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _MapPlaceholder(),
          const SizedBox(height: 24),
          _buildDescriptionHintSection(
            notifier, // Corrigido para passar o AddCacheNotifier correto
            isSmallScreen,
          ),
          const SizedBox(height: 24),
          _buildDropdownsSection(notifier, isSmallScreen),
          const SizedBox(height: 24),
          _buildRatingsSection(notifier, isSmallScreen),
          const SizedBox(height: 32),
          _SubmitButton(
            isLoading: notifier.isLoading,
            onPressed: notifier.isLoading ? null : () => _submit(notifier),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionHintSection(
    AddCacheNotifier
    notifier, // Tipo corrigido aqui de CacheNotifier para AddCacheNotifier
    bool isSmallScreen,
  ) {
    final descriptionField = _DescriptionField(
      controller: _descriptionController,
      focusNode: _descriptionFocus,
      onFieldSubmitted: (_) {
        if (notifier.hasHint) {
          FocusScope.of(context).requestFocus(_hintFocus);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
    );

    final hintSection = _HintSection(
      hasHint: notifier.hasHint,
      hintController: _hintController,
      hintFocus: _hintFocus,
      onToggle: notifier.toggleHint,
      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
    );

    if (isSmallScreen) {
      return Column(
        children: [descriptionField, const SizedBox(height: 24), hintSection],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: descriptionField),
        const SizedBox(width: 24),
        Expanded(child: hintSection),
      ],
    );
  }

  Widget _buildDropdownsSection(AddCacheNotifier notifier, bool isSmallScreen) {
    final cacheTypeDropdown = LabeledDropdown<String>(
      label: 'Tipo de Cache',
      items: _cacheTypes,
      itemLabel: (e) => e,
      value: notifier.cacheType,
      onChanged: notifier.setCacheType,
      validator: CacheValidators.dropdown(fieldName: 'O tipo'),
    );

    final cacheSizeDropdown = LabeledDropdown<String>(
      label: 'Tamanho',
      items: _cacheSizes,
      itemLabel: (e) => e,
      value: notifier.cacheSize,
      onChanged: notifier.setCacheSize,
      validator: CacheValidators.dropdown(fieldName: 'O tamanho'),
    );

    if (isSmallScreen) {
      return Column(
        children: [
          cacheTypeDropdown,
          const SizedBox(height: 16),
          cacheSizeDropdown,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: cacheTypeDropdown),
        const SizedBox(width: 24),
        Expanded(child: cacheSizeDropdown),
      ],
    );
  }

  Widget _buildRatingsSection(AddCacheNotifier notifier, bool isSmallScreen) {
    final difficultySelector = RatingSelector(
      label: 'Dificuldade',
      value: notifier.difficulty,
      onChanged: notifier.setDifficulty,
    );

    final terrainSelector = RatingSelector(
      label: 'Terreno',
      value: notifier.terrain,
      onChanged: notifier.setTerrain,
    );

    if (isSmallScreen) {
      return Column(
        children: [
          difficultySelector,
          const SizedBox(height: 16),
          terrainSelector,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: difficultySelector),
        const SizedBox(width: 24),
        Expanded(child: terrainSelector),
      ],
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: const Center(child: Icon(Icons.map, size: 48, color: Colors.grey)),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  const _DescriptionField({
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: 4,
      validator: CacheValidators.description,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: 'Descrição',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _HintSection extends StatelessWidget {
  final bool hasHint;
  final TextEditingController hintController;
  final FocusNode hintFocus;
  final ValueChanged<bool> onToggle;
  final ValueChanged<String>? onFieldSubmitted;

  const _HintSection({
    required this.hasHint,
    required this.hintController,
    required this.hintFocus,
    required this.onToggle,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleButtons(
          isSelected: [hasHint, !hasHint],
          onPressed: (index) => onToggle(index == 0),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Sim'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Não'),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: hasHint
              ? Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: hintController,
                    focusNode: hintFocus,
                    validator: CacheValidators.hint,
                    onFieldSubmitted: onFieldSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Digite a dica...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SubmitButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Criar Novo Cache'),
      ),
    );
  }
}
