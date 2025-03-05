import 'package:coach_potato/auth/auth.dart';
import 'package:coach_potato/home/dashboard.dart';
import 'package:coach_potato/home/home.dart';
import 'package:coach_potato/trainees/trainee_detail.dart';
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
                  return NoTransitionPage<TraineeDetail>(child: TraineeDetail(id: int.parse(id)));
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
