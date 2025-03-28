import 'package:coach_potato/db/util/training_db_util.dart';
import 'package:coach_potato/model/training.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fetch all trainings for a specific trainee
final FutureProviderFamily<List<Training>, String> trainingsForTraineeProvider =
FutureProvider.family<List<Training>, String>((Ref ref, String traineeId) async {
  return await TrainingDbUtil.getTrainings(traineeId);
});

/// Fetch the latest training for a specific trainee
final FutureProviderFamily<Training?, String> latestTrainingProvider =
FutureProvider.family<Training?, String>((Ref ref, String traineeId) async {
  final List<Training> trainings = await ref.watch(trainingsForTraineeProvider(traineeId).future);
  if (trainings.isEmpty) {
    return null;
  }
  return trainings.last;
});

/// Compute the correct week based on the latest training
final FutureProviderFamily<int, String> weekForTraineeProvider =
FutureProvider.family<int, String>((Ref ref, String traineeId) async {
  final Training? latestTraining = await ref.watch(latestTrainingProvider(traineeId).future);

  if (latestTraining == null) {
    return 1;
  }

  return calculateWeek(latestTraining);
});

/// Fetch trainings for the computed week
final FutureProviderFamily<List<Training>, String> trainingsForWeekProvider =
FutureProvider.family<List<Training>, String>((Ref ref, String traineeId) async {
  final int week = await ref.watch(weekForTraineeProvider(traineeId).future);
  final List<Training> trainings = await ref.watch(trainingsForTraineeProvider(traineeId).future);

  return trainings.where((Training training) => training.week == week).toList();
});

int calculateWeek(Training? training) {
  if (training == null) {
    return 1;
  }

  final DateTime createdAt = training.createdAt;
  final DateTime now = DateTime.now();

  final int weekDifference = now.difference(createdAt).inDays ~/ 7;

  final DateTime startOfThisWeek = now.subtract(Duration(days: now.weekday - 1, hours: now.hour, minutes: now.minute, seconds: now.second));
  final DateTime endOfThisWeek = startOfThisWeek.add(const Duration(days: 6, hours: 22, minutes: 59, seconds: 59));

  if (createdAt.isAfter(startOfThisWeek) && createdAt.isBefore(endOfThisWeek)) {
    return training.week;
  }

  return training.week + weekDifference; // TODO + weekDifference or + 1?
}