import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/exercise.dart';
import 'package:coach_potato/model/exercise_set.dart';
import 'package:coach_potato/model/training.dart';
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
  final Map<int, bool> _editMode = <int, bool>{};
  final Map<String, TextEditingController> _controllers = <String, TextEditingController>{};

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEdit(int trainingIndex) {
    setState(() {
      _editMode[trainingIndex] = !(_editMode[trainingIndex] ?? false);
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
                final Training training = widget.trainings[index];
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
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: defPadding * 3,
                                    height: defPadding * 3,
                                    child: IconButton(
                                      onPressed: () => _toggleEdit(index),
                                      icon: Icon(Icons.close, size: 14),
                                      tooltip: 'Cancel edit',
                                    ),
                                  ),
                                  SizedBox(
                                    width: defPadding * 3,
                                    height: defPadding * 3,
                                    child: IconButton(
                                      onPressed: () => _toggleEdit(index),
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
                                          child: const Text('Remove exercise', style: TextStyle(color: Colors.redAccent)),
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
                                                  Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 60,
                                                        child: TextField(
                                                          controller: _getController('${training.hashCode}_${exercise.hashCode}_${i}_weight', set.weight.toString()),
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
                                                          controller: _getController('${training.hashCode}_${exercise.hashCode}_${i}_reps', set.reps.toString()),
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
                                                        icon: const Icon(Icons.remove_circle_outline, size: 16, color: Colors.redAccent),
                                                        tooltip: 'Remove set',
                                                        onPressed: () => setState(() => exercise.sets.removeAt(i)),
                                                      ),
                                                    ],
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
