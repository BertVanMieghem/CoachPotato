import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/home/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    required this.context, required this.ref, required this.title, required this.route, required this.activeRoute, this.available = true, super.key,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String title;
  final String route;
  final String activeRoute;
  final bool available;

  @override
  Widget build(BuildContext context) {
    final bool isActive = route == activeRoute;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: isActive ? Theme.of(context).colorScheme.inversePrimary : Colors.transparent,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: isActive ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            if (!available)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: defPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defPadding),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 8,
                  ),
                ),
              ),
          ],
        ),
        hoverColor: Theme.of(context).colorScheme.secondaryContainer,
        onTap: () {
          if (available) {
            ref.read(activeMenuItemProvider.notifier).state = route;
            context.go(route);
          }
        },
      ),
    );
  }
}
