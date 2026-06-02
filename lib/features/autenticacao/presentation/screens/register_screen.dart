import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/side_panel.dart';
import '../widgets/layout.dart';
import '../widgets/register_form.dart';

import '../../../../core/theme/app_colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              RegisterForm(onSuccess: () => context.go('/login')),
              const SizedBox(height: 20),
              _buildLoginSection(context),
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
                    RegisterForm(onSuccess: () => context.go('/login')),
                    const SizedBox(height: 20),
                    _buildLoginSection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Já tem uma conta? ', style: TextStyle(fontSize: 16)),
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text(
            'Faça o Login',
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
