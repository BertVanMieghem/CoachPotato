import 'package:coach_potato/home/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuItem extends ConsumerWidget {
  const MenuItem({required this.title, required this.route, super.key});

  final String title;
  final String route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isActive = ref.watch(activeMenuItemProvider) == route;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.primary,
        ),
      ),
      tileColor: isActive ? Theme.of(context).colorScheme.inversePrimary : null,
      hoverColor: Theme.of(context).colorScheme.secondaryContainer,
      onTap: () {
        ref.read(activeMenuItemProvider.notifier).state = route;
        context.go(route);
      },
    );
  }
}