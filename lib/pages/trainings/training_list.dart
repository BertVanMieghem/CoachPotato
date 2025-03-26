import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/exercise.dart';
import 'package:coach_potato/model/exercise_set.dart';
import 'package:coach_potato/model/training.dart';
import 'package:coach_potato/provider/training_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingList extends ConsumerWidget {
  const TrainingList({required this.traineeId, super.key});

  final String traineeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Training>> traineeTrainings = ref.watch(trainingsForTraineeProvider(traineeId));

    return traineeTrainings.when(
      data: (List<Training> trainings) => ListView.builder(
        shrinkWrap: true,
        itemCount: trainings.length,
        itemBuilder: (BuildContext context, int index) {
          final Training training = trainings[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defPadding / 2)),
            child: Padding(
              padding: const EdgeInsets.all(defPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Training ${index + 1}'),
                  for (final Exercise exercise in training.exercises)
                    Padding(
                      padding: const EdgeInsets.only(bottom: defPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: defPadding / 2),
                            child: Text(exercise.name),
                          ),
                          Row(
                            spacing: defPadding * 4,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <SizedBox>[
                                  for (final (int indexed, ExerciseSet set) in exercise.sets.indexed)
                                    SizedBox(
                                      height: defPadding * 2,
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(text: '${indexed + 1}  ', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                            TextSpan(text: '${set.weight}kg x ${set.reps}', style: Theme.of(context).textTheme.bodyMedium),
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
                                      child: Text(set.note ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, _) => Center(child: Text('Error: ${error.toString()}')),
    );
  }
}
