import 'package:firebase_auth/firebase_auth.dart';

class CoachProvider {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static String getCoachUid() {
    final String? coachUid = auth.currentUser?.uid;
    if (coachUid == null) {
      throw Exception('No authenticated coach');
    }
    return coachUid;
  }
}