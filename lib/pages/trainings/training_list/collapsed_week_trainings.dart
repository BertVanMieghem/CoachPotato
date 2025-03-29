import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class CollapsedWeekTrainings extends StatelessWidget {
  const CollapsedWeekTrainings({required this.numberOfTrainings, required this.onClick, super.key});

  final int numberOfTrainings;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onClick(),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defPadding / 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(defPadding),
            child: Text('$numberOfTrainings trainings...', style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
          ),
        ),
      ),
    );
  }
}
