import 'package:coach_potato/model/exercise_set.dart';
import 'package:coach_potato/model/training.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'note': note,
      'sets': sets.map((ExerciseSet s) => s.toMap()).toList(),
    };
  }

  Exercise copy() {
    return Exercise(
      name: name,
      sets: sets.map((ExerciseSet s) => s.copy()).toList(),
      note: note,
    );
  }
}