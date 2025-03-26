import 'package:coach_potato/model/exercise_set.dart';

class Exercise {
  factory Exercise.fromMap(Map<String, dynamic> data) => Exercise(
    name: data['name'] as String,
    note: data['note'] as String?,
    sets: parseExerciseSets(data['sets'] as List<dynamic>),
  );

  Exercise({
    required this.name,
    required this.sets,
    this.note,
  });

  final String name;
  final String? note;
  final List<ExerciseSet> sets;

  static List<ExerciseSet> parseExerciseSets(List<dynamic> sets) {
    return sets.map((dynamic s) => ExerciseSet.fromMap(s as Map<String, dynamic>)).toList();
  }
}