import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingList extends ConsumerWidget {
  const TrainingList({required this.traineeId, super.key});

  final String traineeId;

  Widget _addTrainingButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defPadding),
        ),
      ),
      child: Row(
        spacing: defPadding / 2,
        children: <Widget>[
          Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
          const Text('Add Training'),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(defPadding / 2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _addTrainingButton(context),
          ],
        ),
      ),
    );
  }
}
