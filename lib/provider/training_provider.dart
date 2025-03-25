import 'package:coach_potato/db/util/training_db_util.dart';
import 'package:coach_potato/model/training.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProviderFamily<List<Training>, String> trainingsForTraineeProvider =
FutureProvider.family<List<Training>, String>((Ref ref, String traineeId) async {
  return await TrainingDbUtil.getTrainings(traineeId);
});
