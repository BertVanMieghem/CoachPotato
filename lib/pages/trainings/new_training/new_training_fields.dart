import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/pages/trainings/new_training/exercise_fields.dart';
import 'package:flutter/material.dart';

class NewTrainingFields extends StatefulWidget {
  const NewTrainingFields({
    required this.traineeId,
    required this.onFinished,
    super.key,
  });

  final String traineeId;
  final VoidCallback onFinished;

  @override
  NewTrainingFieldsState createState() => NewTrainingFieldsState();
}

class NewTrainingFieldsState extends State<NewTrainingFields> {
  final TextEditingController _descriptionController = TextEditingController();
  final List<GlobalKey<ExerciseFieldsState>> _exerciseKeys = <GlobalKey<ExerciseFieldsState>>[];

  @override
  void initState() {
    _addExercise();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _addExercise() {
    setState(() {
      _exerciseKeys.add(GlobalKey<ExerciseFieldsState>());
    });
  }

  void _removeExercise(int index) {
    setState(() {
      _exerciseKeys.removeAt(index);
    });
  }

  void _confirm() {
    final String description = _descriptionController.text.trim();

    final List<Map<String, dynamic>> exercisesData = _exerciseKeys
        .map((GlobalKey<ExerciseFieldsState> key) => key.currentState?.getData() ?? <String, dynamic>{})
        .toList();

    // TODO send data to firestore

    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: defPadding),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Training description',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        // List of exercises
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _exerciseKeys.length,
          itemBuilder: (BuildContext context, int index) {
            return ExerciseFields(
              key: _exerciseKeys[index],
              onRemove: () => _removeExercise(index),
            );
          },
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: _addExercise,
          child: const Text('Add exercise'),
        ),
        const SizedBox(height: defPadding),
        Padding(
          padding: const EdgeInsets.only(right: defPadding * 3),
          child: Row(
            spacing: defPadding,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: widget.onFinished,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _confirm,
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.onSurface,
          height: 20,
          thickness: 0.5,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
