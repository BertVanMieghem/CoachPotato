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

  Map<int, List<Training>> groupTrainingsByWeek(List<Training> trainings) {
    final Map<int, List<Training>> groupedTrainings = <int, List<Training>>{};
    for (final Training training in trainings) {
      final int week = training.week;
      groupedTrainings.putIfAbsent(week, () => <Training>[]).add(training);
    }
    return groupedTrainings;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Training>> traineeTrainings = ref.watch(trainingsForTraineeProvider(traineeId));

    return traineeTrainings.when(
      data: (List<Training> trainings) {

        // group trainings by week
        final Map<int, List<Training>> groupedTrainings = groupTrainingsByWeek(trainings);
        groupedTrainings[2] = groupedTrainings[1]!;

        final List<int> weeks = groupedTrainings.keys.toList()..sort();

        return ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: weeks.length,
          itemBuilder: (BuildContext context, int index) {
            final int week = weeks[index];
            final List<Training> weekTrainings = groupedTrainings[week]!;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column: Week box + dynamic connecting line
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Week Number Box
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'W$week',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Dynamically expanding line (if not last week)
                    if (index != 0)
                      Flexible(
                        child: Container(
                          height: 750,
                          width: 4,
                          color: Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),

                // Right column: Training Cards
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: weekTrainings.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Training training = weekTrainings[index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defPadding / 2)),
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
                ),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, _) => Center(child: Text('Error: ${error.toString()}')),
    );
  }
}
