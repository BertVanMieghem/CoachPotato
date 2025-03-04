import 'package:coach_potato/auth/auth.dart';
import 'package:coach_potato/home/dashboard.dart';
import 'package:coach_potato/home/home.dart';
import 'package:coach_potato/trainees/trainees.dart';
import 'package:coach_potato/home/trainings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>((Ref<GoRouter> ref) {
  return GoRouter(
    initialLocation: '/auth',
    routes: <RouteBase>[
      GoRoute(
        path: '/auth',
        builder: (BuildContext context, GoRouterState state) => const AuthPage(),
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) => HomePage(),
        routes: <GoRoute>[
          GoRoute(
            path: '/dashboard',
            builder: (BuildContext context, GoRouterState state) => const Dashboard(),
          ),
          GoRoute(
            path: '/trainees',
            builder: (BuildContext context, GoRouterState state) => const Trainees(),
          ),
          GoRoute(
            path: '/trainings',
            builder: (BuildContext context, GoRouterState state) => const Trainings(),
          ),
        ],
      ),
    ],
  );
});
