import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_integrador/providers/Servico_Autenticacao.dart';

import 'features/autenticacao/presentation/screens/login_screen.dart';
import 'features/autenticacao/presentation/screens/register_screen.dart';
import 'features/homepage/presentation/screens/homepage_screen.dart';

final servicoAuth = ServicoAutenticacao();

final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final autenticado = servicoAuth.autenticado;
    final naRotaDeLogin = state.matchedLocation == "./login";

    if (!autenticado && !naRotaDeLogin) {
      return '/login';
    }

    if (autenticado && naRotaDeLogin) {
      return '/';
    }

    // Caso não necessite de redirecionamento
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const HomepageScreen(),
    ),
  ],
);