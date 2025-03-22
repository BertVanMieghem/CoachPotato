import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coach_potato/model/exercise.dart';

final FutureProviderFamily<List<Exercise>, String> exercisesProvider = FutureProvider.family<List<Exercise>, String>((Ref ref, String trainingId) async {
  final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('trainings')
      .doc(trainingId)
      .collection('exercises')
      .orderBy('orderIndex')
      .get();

  return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data();
    data['id'] = doc.id;
    return Exercise.fromMap(data);
  }).toList();
});