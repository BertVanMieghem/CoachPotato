import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_potato/model/exercise.dart';

class Training {
  factory Training.fromMap(Map<String, dynamic> data) => Training(
    id: data['id'] as String,
    coachId: data['coachId'] as String,
    traineeId: data['traineeId'] as String,
    week: data['week'] as int,
    note: data['note'] as String,
    exercises: parseExercises(data['exercises'] as List<dynamic>),
    createdAt: (data['createdAt'] as Timestamp).toDate(),
    updatedAt: (data['updatedAt'] as Timestamp).toDate(),
  );

  Training({
    required this.id,
    required this.coachId,
    required this.traineeId,
    required this.exercises,
    required this.week,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String coachId;
  final String traineeId;
  final List<Exercise> exercises;
  final int week;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;

  static List<Exercise> parseExercises(List<dynamic> exercises) {
    return exercises.map((dynamic e) => Exercise.fromMap(e as Map<String, dynamic>)).toList();
  }

  Training copy() {
    return Training(
      id: id,
      coachId: coachId,
      traineeId: traineeId,
      week: week,
      note: note,
      exercises: exercises.map((Exercise e) => e.copy()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}