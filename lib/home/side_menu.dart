import 'package:coach_potato/home/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final StateProvider<String> activeMenuItemProvider = StateProvider<String>((Ref ref) => '/dashboard');

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String activeRoute = ref.watch(activeMenuItemProvider);

    final List<Map<String, dynamic>> menuItems = <Map<String, dynamic>>[
      <String, dynamic>{'title': AppLocalizations.of(context)!.home_dashboard, 'route': '/dashboard', 'available': true},
      <String, dynamic>{'title': AppLocalizations.of(context)!.home_trainees, 'route': '/trainees', 'available': true},
      <String, dynamic>{'title': AppLocalizations.of(context)!.home_trainings, 'route': '/trainings', 'available': true},
      <String, dynamic>{'title': AppLocalizations.of(context)!.home_templates, 'route': '/templates', 'available': false},
      <String, dynamic>{'title': AppLocalizations.of(context)!.home_financial, 'route': '/financial', 'available': false},
    ];

    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_outline, size: 100, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: 50),
          ...menuItems.map((Map<String, dynamic> item) => MenuItem(context: context, ref: ref, title: item['title']!, route: item['route']!, activeRoute: activeRoute, available: item['available']!)),
        ],
      ),
    );
  }
}

