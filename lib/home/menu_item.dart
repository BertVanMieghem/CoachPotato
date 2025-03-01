import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18),
      ),
      hoverColor: Theme.of(context).colorScheme.primary.withAlpha(50),
      onTap: () {
        // Add navigation or logic
      },
    );
  }
}