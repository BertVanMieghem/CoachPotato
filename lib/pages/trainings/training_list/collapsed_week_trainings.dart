import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class CollapsedWeekTrainings extends StatelessWidget {
  const CollapsedWeekTrainings({required this.numberOfTrainings, super.key});

  final int numberOfTrainings;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defPadding / 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defPadding),
        child: Text('$numberOfTrainings trainings...', style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
      ),
    );
  }
}
