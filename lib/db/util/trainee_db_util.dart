import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coach_potato/model/trainee.dart';

class TraineeDbUtil {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<List<Trainee>> getAllTrainees() async {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('trainees')
        .where('coach_id', isEqualTo: coachUid)
        .get();

    return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      return Trainee.fromMap(doc.data()..['id'] = doc.id);
    }).toList();
  }

  static Future<Trainee> getTraineeById(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
    await firestore.collection('trainees').doc(id).get();

    if (!doc.exists) {
      throw Exception('Trainee not found');
    }

    return Trainee.fromMap(doc.data()!..['id'] = doc.id);
  }
}
