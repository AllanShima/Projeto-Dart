import 'package:flutter/material.dart';

class AddCacheModal extends StatefulWidget {
  const AddCacheModal({super.key});

  @override
  State<AddCacheModal> createState() => _AddCacheModalState();
}

class _AddCacheModalState extends State<AddCacheModal> {
  // Estados para os seletores
  String cacheType = 'Tradicional';
  String cacheSize = 'Micro';
  int difficulty = 1;
  int terrain = 1;
  bool hasHint = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildAddressInput(),
              const SizedBox(height: 16),
              _buildMapPlaceholder(),
              const SizedBox(height: 24),
              
              // Grid de inputs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDescriptionField()),
                  const SizedBox(width: 24),
                  Expanded(child: _buildHintSection()),
                ],
              ),
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(child: _buildDropdown('Tipo de Cache', ['Tradicional', 'Mistério', 'Multi'])),
                  const SizedBox(width: 24),
                  Expanded(child: _buildDropdown('Tamanho', ['Micro', 'Pequeno', 'Regular', 'Grande'])),
                ],
              ),
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(child: _buildRatingSelector('Dificuldade', difficulty, (val) => setState(() => difficulty = val))),
                  const SizedBox(width: 24),
                  Expanded(child: _buildRatingSelector('Terreno', terrain, (val) => setState(() => terrain = val))),
                ],
              ),
              const SizedBox(height: 32),
              
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets de Apoio ---

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adicionar um Novo Cache',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
            ),
            Text(
              'Compartilhe a localização de um novo cache posicionado!',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAddressInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar Endereço...',
        prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: NetworkImage('https://placeholder.com/map_bg'), // Substituir por imagem real ou Google Maps
          fit: BoxFit.cover,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.map, size: 40, color: Color(0xFF0D47A1)),
              Text('Visualização do Mapa', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('-23.5505, -46.6333', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Ex: Localizado na frente do paineira',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Colors.grey[50],
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _buildHintSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Adicionar Dica', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
        const SizedBox(height: 8),
        ToggleButtons(
          borderRadius: BorderRadius.circular(8),
          isSelected: [hasHint, !hasHint],
          onPressed: (index) => setState(() => hasHint = index == 0),
          constraints: const BoxConstraints(minHeight: 36, minWidth: 60),
          children: const [Text('Sim'), Text('Não')],
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Ex: Onde sons ecoam...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Colors.grey[50],
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) {},
        ),
      ],
    );
  }

  Widget _buildRatingSelector(String label, int currentVal, Function(int) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            int val = index + 1;
            bool isSelected = val <= currentVal;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(val),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.grey[300] : Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(child: Text('$val')),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: const Text('Criar Novo Cache', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}