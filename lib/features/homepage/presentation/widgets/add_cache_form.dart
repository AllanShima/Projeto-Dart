import 'package:flutter/material.dart';

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

  String? _cacheType;
  String? _cacheSize;
  int _difficulty = 1;
  int _terrain = 1;
  bool _hasHint = false;

  bool _isLoading = false;

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.white),
                SizedBox(width: 12),
                Text('Cache criado com sucesso!'),
              ],
            ),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            duration: const Duration(milliseconds: 2000),
            showCloseIcon: true,
          ),
        );
        widget.onSuccess();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Erro ao criar cache: $e')),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            duration: const Duration(milliseconds: 2000),
            showCloseIcon: true,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _addressController,
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
            validator: CacheValidators.address,
            decoration: InputDecoration(
              hintText: 'Buscar Endereço...',
              prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Color(0xFF0D47A1),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 16),

          const _MapPlaceholder(),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _DescriptionField(
                  controller: _descriptionController,
                  focusNode: _descriptionFocus,
                  onFieldSubmitted: (_) {
                    if (_hasHint) {
                      FocusScope.of(context).requestFocus(_hintFocus);
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _HintSection(
                  hasHint: _hasHint,
                  hintController: _hintController,
                  hintFocus: _hintFocus,
                  onToggle: (value) => setState(() => _hasHint = value),
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: LabeledDropdown<String>(
                  label: 'Tipo de Cache',
                  items: _cacheTypes,
                  itemLabel: (e) => e,
                  value: _cacheType,
                  onChanged: (val) => setState(() => _cacheType = val),
                  validator: CacheValidators.dropdown(fieldName: 'O tipo'),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: LabeledDropdown<String>(
                  label: 'Tamanho',
                  items: _cacheSizes,
                  itemLabel: (e) => e,
                  value: _cacheSize,
                  onChanged: (val) => setState(() => _cacheSize = val),
                  validator: CacheValidators.dropdown(fieldName: 'O tamanho'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: RatingSelector(
                  label: 'Dificuldade',
                  value: _difficulty,
                  onChanged: (val) => setState(() => _difficulty = val),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: RatingSelector(
                  label: 'Terreno',
                  value: _terrain,
                  onChanged: (val) => setState(() => _terrain = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          _SubmitButton(
            isLoading: _isLoading,
            onPressed: _isLoading ? null : _submit,
          ),
        ],
      ),
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
        image: const DecorationImage(
          image: AssetImage('assets/images/geocache_background.jpg'),
          fit: BoxFit.cover,
          opacity: 0.3,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.map, size: 40, color: Color(0xFF0D47A1)),
              Text(
                'Visualização do Mapa',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '-23.5505, -46.6333',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descrição',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          maxLines: 4,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: onFieldSubmitted,
          validator: CacheValidators.description,
          decoration: InputDecoration(
            hintText: 'Ex: Localizado na frente do paineira',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF0D47A1),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            fillColor: Colors.grey[50],
            filled: true,
          ),
        ),
      ],
    );
  }
}

class _HintSection extends StatefulWidget {
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
  State<_HintSection> createState() => _HintSectionState();
}

class _HintSectionState extends State<_HintSection> {
  late bool _localHasHint;

  @override
  void initState() {
    super.initState();
    _localHasHint = widget.hasHint;
  }

  @override
  void didUpdateWidget(_HintSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasHint != widget.hasHint) {
      setState(() => _localHasHint = widget.hasHint);
    }
  }

  void _handleToggle(bool value) {
    setState(() => _localHasHint = value);
    widget.onToggle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Adicionar Dica',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 8),
        ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          isSelected: [_localHasHint, !_localHasHint],
          onPressed: (index) => _handleToggle(index == 0),
          constraints: const BoxConstraints(minHeight: 36, minWidth: 60),
          children: const [Text('Sim'), Text('Não')],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: _localHasHint
              ? Padding(
                  key: const ValueKey('hintFieldVisible'),
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    key: const ValueKey('hintField'),
                    controller: widget.hintController,
                    focusNode: widget.hintFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    validator: _localHasHint ? CacheValidators.hint : null,
                    decoration: InputDecoration(
                      hintText: 'Ex: Onde sons ecoam...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF0D47A1),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      fillColor: Colors.grey[50],
                      filled: true,
                    ),
                  ),
                )
              : const SizedBox(key: ValueKey('hintFieldHidden')),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading
              ? Colors.grey.shade400
              : const Color(0xFF1976D2),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Criar Novo Cache',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
