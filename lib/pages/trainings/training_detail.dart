import 'package:coach_potato/model/exercise.dart';
import 'package:coach_potato/provider/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDetail extends ConsumerWidget {
  const TrainingDetail({required this.trainingId, super.key});
  final String trainingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Exercise>> exercisesAsync = ref.watch(exercisesProvider(trainingId));

    return exercisesAsync.when(
      data: (List<Exercise> exercises) => ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (BuildContext context, int index) {
          final Exercise exercise = exercises[index];
          return ListTile(
            title: Text(exercise.name),
            // subtitle: Text('Sets: ${exercise.sets}, Reps: ${exercise.reps}, Weight: ${exercise.weight}'),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, _) => Center(child: Text('Error: $error')),
    );
  }
}