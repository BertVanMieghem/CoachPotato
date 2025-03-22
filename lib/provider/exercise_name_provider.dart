import 'package:coach_potato/db/util/local_exercise_db_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProvider<List<String>> exerciseNamesProvider = FutureProvider<List<String>>((Ref ref) async {
  return await LocalExerciseDbUtil.getAllExerciseNames();
});
