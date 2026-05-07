import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'providers/servico_autenticacao.dart';

import 'features/autenticacao/presentation/screens/login_screen.dart';
import 'features/autenticacao/presentation/screens/register_screen.dart';
import 'features/homepage/presentation/screens/homepage_screen.dart';

final servicoAuth = ServicoAutenticacao();

final GoRouter router = GoRouter(
  initialLocation: '/login',
  refreshListenable: servicoAuth,
  redirect: (BuildContext context, GoRouterState state) {
    final autenticado = servicoAuth.autenticado;
    final naRotaDeLogin = state.matchedLocation == "/login";
    final naRotaDeCadastro = state.matchedLocation == "/register";

    print(autenticado);
    print(naRotaDeLogin);
    print(naRotaDeCadastro);

    if (!autenticado && !naRotaDeLogin && !naRotaDeCadastro) {
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
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomepageScreen(),
    ),
  ],
);
