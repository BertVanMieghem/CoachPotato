import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/db/util/training_db_util.dart';
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
  final List<GlobalKey<ExerciseFieldsState>> _exerciseKeys = <GlobalKey<ExerciseFieldsState>>[];
  bool _isLoading = false;

  @override
  void initState() {
    _addExercise();
    super.initState();
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

  void _confirm() async {
    final List<Map<String, dynamic>> exercisesData = _exerciseKeys
        .map((GlobalKey<ExerciseFieldsState> key) => key.currentState?.getData() ?? <String, dynamic>{})
        .toList();

    // TODO send data to firestore
    print(exercisesData);

    setState(() => _isLoading = true);
    await TrainingDbUtil.createTraining(
      traineeId: widget.traineeId,
      exercises: exercisesData,
    );
    setState(() => _isLoading = false);

    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: defPadding),
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
                child: _isLoading
                    ? SizedBox(
                  width: defPadding,
                  height: defPadding,
                  child: const CircularProgressIndicator(),
                ) : const Text('Confirm'),
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
