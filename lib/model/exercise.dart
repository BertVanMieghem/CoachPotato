import 'package:coach_potato/model/exercise_set.dart';

class Exercise {
  factory Exercise.fromMap(Map<String, dynamic> data) => Exercise(
    id: data['id'] as String,
    name: data['name'] as String,
    note: data['note'] as String?,
    sets: (data['sets'] as List<dynamic>?)
        ?.map((s) => ExerciseSet.fromMap(s as Map<String, dynamic>))
        .toList() ??
        [],
  );

  Exercise({
    required this.id,
    required this.name,
    this.note,
    required this.sets,
  });

  final String id;
  final String name;
  final String? note;
  final List<ExerciseSet> sets;
}