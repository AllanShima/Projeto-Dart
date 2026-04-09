import 'package:flutter/material.dart';
import 'features/autenticacao/presentation/screens/login_screen.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoQuest',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
