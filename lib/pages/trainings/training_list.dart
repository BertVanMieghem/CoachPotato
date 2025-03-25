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
      data: (List<Training> trainings) => SingleChildScrollView(
        child: Column(
          children: <ListView>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: trainings.length,
              itemBuilder: (BuildContext context, int index) {
                final Training training = trainings[index];
                return ListTile(
                  title: Text(training.createdAt.toString()),
                  onTap: () {
                    // Navigate to training detail page
                  },
                );
              },
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, _) => Center(child: Text('Error: ${error.toString()}')),
    );
  }
}
