import 'package:coach_potato/home/dashboard.dart';
import 'package:coach_potato/home/side_menu.dart';
import 'package:coach_potato/trainees/trainees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String activeRoute = ref.watch(activeMenuItemProvider);

    final Map<String, Widget> pages = <String, Widget>{
      '/dashboard': const Dashboard(),
      '/trainees': const Trainees(),
      '/trainings': const Placeholder(),
      '/templates': const Placeholder(),
      '/financial': const Placeholder(),
    };

    return Scaffold(
      body: Row(
        children: <Widget>[
          const SideMenu(),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: pages[activeRoute] ?? const Dashboard(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

