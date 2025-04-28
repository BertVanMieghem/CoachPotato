import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class TrainingEditFields extends StatelessWidget {
  const TrainingEditFields({
    required this.weightController,
    required this.repController,
    required this.removeSet,
    super.key,
  });

  final TextEditingController weightController;
  final TextEditingController repController;
  final VoidCallback removeSet;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 60,
          child: TextField(
            controller: weightController,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const Text(' kg', style: TextStyle(fontSize: 12)),
        const SizedBox(width: defPadding),
        SizedBox(
          width: 60,
          child: TextField(
            controller: repController,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const Text(' reps', style: TextStyle(fontSize: 12)),
        const SizedBox(width: defPadding),
        IconButton(
          icon: Icon(Icons.remove_circle_outline, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
          tooltip: 'Remove set',
          onPressed: removeSet,
        ),
      ],
    );
  }
}
