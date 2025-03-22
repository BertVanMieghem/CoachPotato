import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/pages/trainings/new_training/exercise_autocomplete_field.dart';
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
  _NewTrainingFieldsState createState() => _NewTrainingFieldsState();
}

class _NewTrainingFieldsState extends State<NewTrainingFields> {
  final TextEditingController _descriptionController = TextEditingController();

  // Each exercise is represented by a map holding its TextEditingControllers.
  final List<Map<String, dynamic>> _exercises = <Map<String, dynamic>>[];

  @override
  void dispose() {
    _descriptionController.dispose();
    for (Map<String, dynamic> exercise in _exercises) {
      exercise['name'].dispose();
      exercise['sets'].dispose();
      exercise['reps'].dispose();
      exercise['weight'].dispose();
      exercise['note'].dispose();
    }
    super.dispose();
  }

  void _addExercise() {
    setState(() {
      _exercises.add(<String, TextEditingController>{
        'name': TextEditingController(),
        'sets': TextEditingController(),
        'reps': TextEditingController(),
        'weight': TextEditingController(),
        'note': TextEditingController(),
      });
    });
  }

  void _removeExercise(int index) {
    setState(() {
      final Map<String, dynamic> exercise = _exercises.removeAt(index);
      exercise['name'].dispose();
      exercise['sets'].dispose();
      exercise['reps'].dispose();
      exercise['weight'].dispose();
      exercise['note'].dispose();
    });
  }

  void _confirm() {
    final String description = _descriptionController.text.trim();

    // Gather exercise data from each entry.
    final List<Map<String, dynamic>> exercisesData = _exercises.map((Map<String, dynamic> exercise) {
      return <String, dynamic>{
        'name': exercise['name'].text.trim(),
        'sets': int.tryParse(exercise['sets'].text.trim()) ?? 0,
        'reps': int.tryParse(exercise['reps'].text.trim()) ?? 0,
        'weight': double.tryParse(exercise['weight'].text.trim()) ?? 0.0,
        'note': exercise['note'].text.trim(),
      };
    }).toList();

    // TODO create training in firestore

    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Training Description',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        // List of exercises
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _exercises.length,
          itemBuilder: (BuildContext context, int index) {
            final Map<String, dynamic> exercise = _exercises[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: defPadding / 2,
                  children: <Widget>[
                    Flexible(
                      child: ExerciseAutocompleteField(),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              controller: exercise['reps'],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Reps',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              controller: exercise['weight'],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Weight',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeExercise(index),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: _addExercise,
          child: const Text('Add Exercise'),
        ),
        const SizedBox(height: defPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // Signal finished (cancel)
                widget.onFinished();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _confirm,
              child: const Text('Confirm'),
            ),
          ],
        ),
      ],
    );
  }
}
