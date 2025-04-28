import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/db/util/training_db_util.dart';
import 'package:coach_potato/model/exercise.dart';
import 'package:coach_potato/model/exercise_set.dart';
import 'package:coach_potato/model/training.dart';
import 'package:coach_potato/pages/trainings/new_training/exercise_fields.dart';
import 'package:coach_potato/pages/trainings/training_list/training_edit/training_edit_fields.dart';
import 'package:flutter/material.dart';

class ExpandedWeekTrainings extends StatefulWidget {
  const ExpandedWeekTrainings({
    required GlobalKey<State<StatefulWidget>> listKey,
    required this.trainings,
    super.key,
  }) : _listKey = listKey;

  final GlobalKey<State<StatefulWidget>> _listKey;
  final List<Training> trainings;

  @override
  State<ExpandedWeekTrainings> createState() => _ExpandedWeekTrainingsState();
}

class _ExpandedWeekTrainingsState extends State<ExpandedWeekTrainings> {
  bool _isLoading = false;
  bool _showNewExerciseFields = false;

  final Map<int, Training> _editableCopies = <int, Training>{};
  final Map<int, bool> _editMode = <int, bool>{};
  final Map<String, TextEditingController> _controllers = <String, TextEditingController>{};

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveTraining(int index) async {
    final Training? editedTraining = _editableCopies[index];
    if (editedTraining == null) return;

    setState(() => _isLoading = true);
    await TrainingDbUtil.updateTraining(editedTraining);

    setState(() {
      widget.trainings[index] = editedTraining;
      _editableCopies.remove(index);
      _editMode[index] = false;
      _isLoading = false;
    });
  }


  void _cancelTraining(int index) {
    setState(() {
      _editableCopies.remove(index);
      _editMode[index] = false;
    });
  }


  void _toggleEdit(int trainingIndex) {
    setState(() {
      _isLoading = false;
      final bool currentlyEditing = _editMode[trainingIndex] ?? false;
      _editMode[trainingIndex] = !currentlyEditing;

      if (!currentlyEditing) {
        // Entering edit mode -> create a deep copy
        _editableCopies[trainingIndex] = widget.trainings[trainingIndex].copy();
      } else {
        // Leaving edit mode -> clean up
        _editableCopies.remove(trainingIndex);
      }
    });
  }

  TextEditingController _getController(String key, String initial) {
    return _controllers.putIfAbsent(key, () => TextEditingController(text: initial));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        key: widget._listKey,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: widget.trainings.length,
              itemBuilder: (BuildContext context, int index) {
                final Training training = _editableCopies[index] ?? widget.trainings[index];
                final bool inEditMode = _editMode[index] ?? false;

                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defPadding / 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(defPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Training ${index + 1}', style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
                                Text('created on ${training.createdAt}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                                if (training.note.isNotEmpty)
                                  Text(training.note,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                  ),
                              ],
                            ),
                            if (inEditMode)
                              if (_isLoading)
                                SizedBox(
                                  width: defPadding,
                                  height: defPadding,
                                  child: const CircularProgressIndicator(),
                                )
                              else
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: defPadding * 3,
                                      height: defPadding * 3,
                                      child: IconButton(
                                        onPressed: () => _cancelTraining(index),
                                        icon: Icon(Icons.close, size: 14),
                                        tooltip: 'Cancel edit',
                                      ),
                                    ),
                                    SizedBox(
                                      width: defPadding * 3,
                                      height: defPadding * 3,
                                      child: IconButton(
                                        onPressed: () => _saveTraining(index),
                                        icon: Icon(Icons.check, size: 14),
                                        tooltip: 'Confirm edit',
                                      ),
                                    ),
                                  ],
                                )
                            else
                              SizedBox(
                                width: defPadding * 3,
                                height: defPadding * 3,
                                child: IconButton(
                                  onPressed: () => _toggleEdit(index),
                                  icon: Icon(Icons.mode_edit_outlined, size: 14),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: defPadding),

                        for (final Exercise exercise in training.exercises)
                          Padding(
                            padding: const EdgeInsets.only(bottom: defPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: defPadding / 2),
                                  child: Row(
                                    spacing: defPadding,
                                    children: <Widget>[
                                      Text(exercise.name),
                                      if (inEditMode)
                                        TextButton(
                                          onPressed: () => setState(() => training.exercises.remove(exercise)),
                                          child: Text('Remove exercise', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                        ),
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        for (final (int i, ExerciseSet set) in exercise.sets.indexed)
                                          SizedBox(
                                            height: defPadding * 2.5,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  '${i + 1}  ',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                                  ),
                                                ),
                                                if (inEditMode)
                                                  TrainingEditFields(
                                                    weightController: _getController('${training.hashCode}_${exercise.hashCode}_${i}_weight', set.weight.toString()),
                                                    repController: _getController('${training.hashCode}_${exercise.hashCode}_${i}_reps', set.reps.toString()),
                                                    removeSet: () => setState(() => exercise.sets.removeAt(i)),
                                                  )
                                                else
                                                  Row(
                                                    spacing: defPadding * 2,
                                                    children: <Text>[
                                                      Text('${set.weight}kg x ${set.reps}', style: Theme.of(context).textTheme.bodyMedium),
                                                      Text(
                                                        set.note ?? '',
                                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                          color: Theme.of(context).colorScheme.onSurface,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (inEditMode)
                          if (_showNewExerciseFields)
                            ExerciseFields(
                              key: GlobalKey<ExerciseFieldsState>(),
                              onRemove: () => (), //_removeExercise(index),
                            )
                          else
                            OutlinedButton(
                              onPressed: () => setState(() => _showNewExerciseFields = !_showNewExerciseFields),
                              child: const Text('Add exercise'),
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
