import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';

import '../widgets/side_panel.dart';
import '../widgets/layout.dart';
import '../widgets/login_form.dart';


import '../../../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                              builder: (context) => HomepageScreen(),
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
            const SidePanel(),
            Layout(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginForm(onSuccess: () { 
                    servicoAuth.login();
                    context.go('/');
                  }),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem conta? ',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => context.go('/register'),
                        child: const Text(
                          'Crie uma',
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
}
