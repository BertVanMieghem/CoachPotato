import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/exercise.dart';
import 'package:coach_potato/model/exercise_set.dart';
import 'package:coach_potato/model/training.dart';
import 'package:flutter/material.dart';

class ExpandedWeekTrainings extends StatelessWidget {
  const ExpandedWeekTrainings({
    required GlobalKey<State<StatefulWidget>> listKey, required this.trainings, super.key,
  }): _listKey = listKey;

  final GlobalKey<State<StatefulWidget>> _listKey;
  final List<Training> trainings;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        key: _listKey,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: trainings.length,
              itemBuilder: (BuildContext context, int index) {
                final Training training = trainings[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defPadding / 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(defPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Training ${index + 1}', style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
                        if (training.note.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: defPadding),
                            child: Text(training.note,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: defPadding),
                          child: Text('created on ${training.createdAt.toString().substring(0, 10)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),

                        for (final Exercise exercise in training.exercises)
                          Padding(
                            padding: const EdgeInsets.only(bottom: defPadding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: defPadding / 2),
                                  child: Text(exercise.name),
                                ),
                                Row(
                                  spacing: defPadding * 4,
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <SizedBox>[
                                        for (final (int indexed, ExerciseSet set)
                                        in exercise.sets.indexed)
                                          SizedBox(
                                            height: defPadding * 2,
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: '${indexed + 1}  ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                          color: Theme.of(
                                                              context)
                                                              .colorScheme
                                                              .onPrimaryContainer)),
                                                  TextSpan(
                                                    text:
                                                    '${set.weight}kg x ${set.reps}',
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <SizedBox>[
                                        for (final ExerciseSet set in exercise.sets)
                                          SizedBox(
                                            height: defPadding * 2,
                                            child: Text(set.note ?? '',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
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
          )],
      ),
    );
  }
}
