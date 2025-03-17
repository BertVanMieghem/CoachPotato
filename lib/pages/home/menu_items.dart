import 'package:coach_potato/pages/home/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final StateProvider<String> activeMenuItemProvider = StateProvider<String>((Ref ref) => '/dashboard');

class MenuItems extends ConsumerWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MenuItem(title: AppLocalizations.of(context)!.home_dashboard, route: '/dashboard'),
        MenuItem(title: AppLocalizations.of(context)!.home_trainees, route: '/trainees'),
        MenuItem(title: AppLocalizations.of(context)!.home_trainings, route: '/trainings'),
        MenuItem(title: AppLocalizations.of(context)!.home_templates, route: '/templates'),
        MenuItem(title: AppLocalizations.of(context)!.home_financial, route: '/financial'),
      ],
    );
  }
}
