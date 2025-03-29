import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/training.dart';
import 'package:coach_potato/pages/trainings/training_list/training_list_tile.dart';
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

        if (trainings.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: defPadding * 6),
            child: Center(
              child: Text('No trainings found', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            ),
          );
        }

        // group trainings by week
        final Map<int, List<Training>> groupedTrainings = groupTrainingsByWeek(trainings);
        final List<int> weeks = groupedTrainings.keys.toList()..sort();

        return ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: weeks.length,
          itemBuilder: (BuildContext context, int index) {
            final int week = weeks[index];
            final List<Training> weekTrainings = groupedTrainings[week]!;

            return TrainingListTile(week: week, trainings: weekTrainings);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, _) => Center(child: Text('Error: ${error.toString()}')),
    );
  }
}