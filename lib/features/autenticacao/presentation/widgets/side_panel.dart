import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  static const String logo = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          const Spacer(),
          Image.asset(logo, height: largura > 600 ? 120 : 40),
          const SizedBox(height: 20),
           Text(
            'GeoQuest',
            style: TextStyle(
              color: Colors.white,
              fontSize: largura > 600 ? 32 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
           Text(
            'Encontre tesouros escondidos',
            style: TextStyle(color: Colors.white, fontSize: largura > 600 ? 20 : 12),
          ),
          const Spacer(),
           Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'Por: Allan, Carlos, Hugo, Ryu, Renan e Emanuelly. Turma BCC-A 5º Termo',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: largura > 600 ? 12 : 6),
            ),
          ),
        ],
      ),
    );
  }
}
