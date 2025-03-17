import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/pages/home/menu_items.dart';
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

    return GestureDetector(
      onTap: () {
        ref.read(activeMenuItemProvider.notifier).state = route;
        context.go(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defPadding * 2),
        color: isActive ? Theme.of(context).colorScheme.inversePrimary : Colors.transparent,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}