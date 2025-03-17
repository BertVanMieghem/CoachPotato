import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coach_potato/model/trainee.dart';

class FavoriteTraineeDbUtil {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<List<Trainee>> getFavoriteTrainees() async {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }

    // Fetch all favorite trainee IDs for this coach
    final QuerySnapshot<Map<String, dynamic>> favoriteSnapshot = await firestore
        .collection('favorites')
        .where('coach_id', isEqualTo: coachUid)
        .get();

    if (favoriteSnapshot.docs.isEmpty) {
      return <Trainee>[];
    }

    // Extract trainee IDs from favorites
    final List<String> traineeIds = favoriteSnapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc['trainee_id'] as String).toList();

    // Fetch all trainees that match these IDs
    final QuerySnapshot<Map<String, dynamic>> traineeSnapshot = await firestore
        .collection('trainees')
        .where(FieldPath.documentId, whereIn: traineeIds)
        .get();

    return traineeSnapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      return Trainee.fromMap(doc.data()..['id'] = doc.id);
    }).toList();
  }

  static Future<void> addFavoriteTrainee(String traineeId) async {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }

    final DocumentReference<Map<String, dynamic>> docRef = firestore.collection('favorites').doc('$coachUid-$traineeId');

    await docRef.set(<String, dynamic>{
      'coach_id': coachUid,
      'trainee_id': traineeId,
      'created_at': FieldValue.serverTimestamp(),
    });
    print('Favorite added');
  }

  static Future<void> removeFavoriteTrainee(String traineeId) async {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }

    final DocumentReference<Map<String, dynamic>> docRef = firestore.collection('favorites').doc('$coachUid-$traineeId');

    await docRef.delete();
  }
}
