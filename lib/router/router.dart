import 'package:coach_potato/auth/auth.dart';
import 'package:coach_potato/auth/sign_up.dart';
import 'package:coach_potato/pages/home/dashboard.dart';
import 'package:coach_potato/pages/home/home.dart';
import 'package:coach_potato/pages/trainees/trainee_detail.dart';
import 'package:coach_potato/pages/trainees/trainees.dart';
import 'package:coach_potato/pages/trainings/trainings.dart';
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
      GoRoute(
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) => const SignUpPage()
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) => HomePage(child: child),
        routes: <GoRoute>[
          GoRoute(
            path: '/dashboard',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage<Dashboard>(child: const Dashboard());
            },
          ),
          GoRoute(
            path: '/trainees',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage<Trainees>(child: const Trainees());
            },
            routes: <GoRoute>[
              GoRoute(
                path: ':id',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  final String id = state.pathParameters['id'] ?? '';
                  return NoTransitionPage<TraineeDetail>(child: TraineeDetail(id: id.toString()));
                },
              ),
            ],
          ),
          GoRoute(
            path: '/trainings',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage<Trainings>(child: const Trainings());
            },
          ),
        ],
      ),
    ],
  );
});
