import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_potato/model/training.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProviderFamily<List<Training>, String> trainingsForTraineeProvider = FutureProvider.family<List<Training>, String>((Ref ref, String traineeId) async {
  final String? coachId = FirebaseAuth.instance.currentUser?.uid;
  if (coachId == null) {
    throw Exception('Not authenticated');
  }

  final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('trainings')
      .where('coachId', isEqualTo: coachId)
      .where('traineeId', isEqualTo: traineeId)
      .orderBy('createdAt', descending: true)
      .get();

  return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data();
    data['id'] = doc.id;
    return Training.fromMap(data);
  }).toList();
});
