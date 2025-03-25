import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_potato/model/exercise.dart';

class Training {
  factory Training.fromMap(Map<String, dynamic> data) {
    print('Training.fromMap: $data');
    return Training(
      id: data['id'] as String,
      coachId: data['coachId'] as String,
      traineeId: data['traineeId'] as String,
      exercises: (data['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
          .toList() ??
          [],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Training({
    required this.id,
    required this.coachId,
    required this.traineeId,
    required this.exercises,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String coachId;
  final String traineeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Exercise> exercises;
}