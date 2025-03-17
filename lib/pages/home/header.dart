import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/provider/auth_provider.dart';
import 'package:coach_potato/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>?> userDataAsync = ref.watch(userDataProvider);

    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: userDataAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object error, StackTrace stackTrace) => Center(child: Text('Error: $error')),
              data: (Map<String, dynamic>? userData) {
                if (userData == null) {
                  return const Center(child: Text('No user data found.'));
                }

                return Text(
                  AppLocalizations.of(context)!.home_greeting(userData['firstName']),
                  style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.onSurface),
                );
              },
            ),
          ),

          Row(
            spacing: defPadding,
            children: <IconButton>[
              IconButton(
                icon: Icon(ref.watch(themeProvider) == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                ),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  ref.read(authServiceProvider).signOut();
                  context.go('/auth');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
