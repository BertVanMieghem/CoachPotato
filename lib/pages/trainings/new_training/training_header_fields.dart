import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class TrainingHeaderFields extends StatelessWidget {
  const TrainingHeaderFields({
    required this.weekController,
    required this.trainingController,
    required this.noteController,
    super.key
  });

  final TextEditingController weekController;
  final TextEditingController trainingController;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: defPadding,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: TextField(
            controller: weekController,
            decoration: InputDecoration(
              labelText: 'Week',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defPadding / 2),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            controller: trainingController,
            decoration: InputDecoration(
              labelText: 'Training',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defPadding / 2),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: noteController,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Training description',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(defPadding / 2),
            ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(defPadding / 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(defPadding / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
