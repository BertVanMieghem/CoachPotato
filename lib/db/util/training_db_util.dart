import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_potato/model/exercise.dart';
import 'package:coach_potato/model/training.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrainingDbUtil {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> createTraining({
    required String traineeId,
    required int week,
    required String note,
    required List<Map<String, dynamic>> exercises,
  }) async {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }

    final DocumentReference<Map<String, dynamic>> trainingRef = FirebaseFirestore.instance.collection('trainings').doc();
    final FieldValue now = FieldValue.serverTimestamp();

    await trainingRef.set(<String, dynamic>{
      'coachId': coachUid,
      'traineeId': traineeId,
      'exercises': exercises,
      'week': week,
      'note': note,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  static Future<List<Training>> getTrainings(String traineeId) async {
    final String? coachId = FirebaseAuth.instance.currentUser?.uid;
    if (coachId == null) {
      throw Exception('Not authenticated');
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance.collection('trainings')
        .where('coachId', isEqualTo: coachId)
        .where('traineeId', isEqualTo: traineeId)
        .orderBy('createdAt', descending: true).get();

    return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Map<String, dynamic> data = doc.data();
      data['id'] = doc.id;
      return Training.fromMap(data);
    }).toList();
  }

  static Future<void> updateTraining(Training training) async {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }

    final DocumentReference<Map<String, dynamic>> trainingRef =
    firestore.collection('trainings').doc(training.id);

    final FieldValue now = FieldValue.serverTimestamp();

    await trainingRef.update(<String, dynamic>{
      'coachId': coachUid,
      'traineeId': training.traineeId,
      'exercises': training.exercises.map((Exercise e) => e.toMap()).toList(),
      'week': training.week,
      'note': training.note,
      'updatedAt': now,
    });
  }


}