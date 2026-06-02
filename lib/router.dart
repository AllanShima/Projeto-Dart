import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'providers/servico_autenticacao.dart';

import 'features/autenticacao/presentation/screens/login_screen.dart';
import 'features/autenticacao/presentation/screens/register_screen.dart';
import 'features/homepage/presentation/screens/homepage_screen.dart';

// Router recebe instancia do ServicoAutenticacao instanciado pelo GetIt
GoRouter buildRouter(ServicoAutenticacao servicoAuth) => GoRouter(
  initialLocation: '/login',
  refreshListenable: servicoAuth,
  redirect: (BuildContext context, GoRouterState state) {
    final autenticado = servicoAuth.autenticado;
    final naRotaDeLogin = state.matchedLocation == '/login';
    final naRotaDeCadastro = state.matchedLocation == '/register';

    if (!autenticado && !naRotaDeLogin && !naRotaDeCadastro) {
      return '/login';
    }

    if (autenticado && naRotaDeLogin) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/', builder: (_, __) => const HomepageScreen()),
  ],
);
