import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingDbUtil {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> createTraining({
    required String coachId,
    required String traineeId,
    required String name,
    required List<Map<String, dynamic>> exercises,
    String? description,
  }) async {
    final DocumentReference<Map<String, dynamic>> trainingRef = FirebaseFirestore.instance.collection('trainings').doc();
    final FieldValue now = FieldValue.serverTimestamp();

    await trainingRef.set(<String, dynamic>{
      'coachId': coachId,
      'traineeId': traineeId,
      'name': name,
      'description': description,
      'createdAt': now,
      'updatedAt': now,
    });

    for (Map<String, dynamic> exercise in exercises) {
      await trainingRef.collection('exercises').add(<String, dynamic>{
        'name': exercise['name'],
        'sets': exercise['sets'],
        'reps': exercise['reps'],
        'weight': exercise['weight'],
        'note': exercise['note'],
        'orderIndex': exercise['orderIndex'],
      });
    }
  }

}