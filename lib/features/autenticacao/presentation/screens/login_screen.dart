import 'package:flutter/material.dart';

import '../widgets/side_panel.dart';
import '../widgets/layout.dart';
import './register_screen.dart';


import '../../../../core/theme/app_colors.dart';

import '../../../homepage/presentation/screens/homepage_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    print('--- Tentativa de Login ---');
    print('Email: $email');
    print('Senha: $password');
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
  
        if ( larguraTela > 600) {
          return _buildDesktopLayout(context);
        } else {
          return _buildMobileLayout(context);
        }
  }

  Widget _buildMobileLayout(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    // final alturaTela = MediaQuery.of(context).size.height;
   return Scaffold(
     body: Container(
        width: double.infinity,
        // height: alturaTela,
        decoration: const BoxDecoration(gradient: AppColors.blueGradient),
          child:Column(
            children: [
               Expanded( 
                  flex: 1,
              child: SidePanel()
              ),
              Expanded(
                flex: 3,
            // child: SingleChildScrollView(
              child: Layout(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                               Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Text(
                      'Bem-Vindo de Volta!',
                      style: TextStyle(
                        color: Color(0xFF003E84),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                               ),
                    const Text(
                      'Faça o Log-in da sua conta para continuar',
                      style: TextStyle(color: Colors.black54, fontSize: 10),
                    ),
                    const SizedBox(height: 12),

                    _buildInputLabel("Email"),
                    _buildTextField(
                      "Ex: email@gmail.com",
                      controller: _emailController,
                    ),

                    const SizedBox(height: 12),

                    _buildInputLabel("Senha"),
                    _buildTextField(
                      "Ex: 1234",
                      isPassword: true,
                      controller: _passwordController,
                    ),

                    const SizedBox(height: 10),
                    Container(
                      width: larguraTela,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: AppColors.blueGradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _onSubmit();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomepageScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Não tem conta? ",
                          style: TextStyle(fontSize: 6),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const RegisterScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return child;
                                    },
                              ),
                            );
                          },
                          child: const Text(
                            "Crie uma",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            // )
               )
            ],
          ),
     )
      );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: larguraTela,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.blueGradient),
        child: Row(
          children: [
            SidePanel(),
            Expanded(
            child: Layout(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Bem-Vindo de Volta!',
                    style: TextStyle(
                      color: Color(0xFF003E84),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Faça o Log-in da sua conta para continuar',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 60),

                  _buildInputLabel("Email"),
                  _buildTextField(
                    "Ex: email@gmail.com",
                    controller: _emailController,
                  ),

                  const SizedBox(height: 30),

                  _buildInputLabel("Senha"),
                  _buildTextField(
                    "Ex: 1234",
                    isPassword: true,
                    controller: _passwordController,
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: larguraTela,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppColors.blueGradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _onSubmit();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomepageScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Não tem conta? ",
                        style: TextStyle(fontSize: larguraTela > 600 ? 18 : 6),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const RegisterScreen(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return child;
                                  },
                            ),
                          );
                        },
                        child:  Text(
                          "Crie uma",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: larguraTela > 600 ? 18 : 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    final largura = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: Text(
          label,
          style:  TextStyle(
            color: Color(0xFF003E84),
            fontWeight: FontWeight.bold,
            fontSize: largura > 600 ? 18 : 6,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    final largura = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding:  EdgeInsets.symmetric(
          horizontal: largura > 600 ? 18 : 6,
          vertical: largura > 600 ? 18 : 6,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
