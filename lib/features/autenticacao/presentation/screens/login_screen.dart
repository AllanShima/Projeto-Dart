import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/side_panel.dart';
import '../widgets/layout.dart';
import '../widgets/login_form.dart';

import '../../../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.blueGradient),
        child: isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        const SidePanel(),
        Layout(
          isMobile: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginForm(onSuccess: () => context.go('/')),
              const SizedBox(height: 20),
              _buildSignUpSection(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: SidePanelMobile(),
          ),
          Expanded(
            child: Layout(
              isMobile: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoginForm(onSuccess: () => context.go('/')),
                    const SizedBox(height: 20),
                    _buildSignUpSection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Não tem conta? ', style: TextStyle(fontSize: 16)),
        TextButton(
          onPressed: () => context.go('/register'),
          child: const Text(
            'Crie uma',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
