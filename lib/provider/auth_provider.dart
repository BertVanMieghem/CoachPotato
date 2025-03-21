import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<FirebaseAuth> authProvider = Provider<FirebaseAuth>((Ref ref) => FirebaseAuth.instance);

final StreamProvider<User?> authStateProvider = StreamProvider<User?>((Ref ref) {
  return ref.watch(authProvider).authStateChanges();
});

final FutureProvider<Map<String, dynamic>?> userDataProvider = FutureProvider<Map<String, dynamic>?>((Ref ref) async {
  final User? user = ref.watch(authStateProvider).value;
  if (user == null) return null;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentSnapshot<Map<String, dynamic>?> userDoc = await firestore.collection('coaches').doc(user.uid).get();
  return userDoc.data();
});

class AuthService {
  AuthService(this._auth);
  final FirebaseAuth _auth;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUpWithEmail(String email, String password, String firstName, String lastName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = userCredential.user!.uid;

      await firestore.collection('coaches').doc(uid).set(<String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> sendSignInLink(String email) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: 'https://coachpotato.com',
      handleCodeInApp: true,
      iOSBundleId: 'com.coach.potato',
      androidPackageName: 'com.coach.potato',
      androidInstallApp: true,
      androidMinimumVersion: '21',
    );

    try {
      await auth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
    } catch (e) {
      print('Error sending sign-in link: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final Provider<AuthService> authServiceProvider = Provider<AuthService>((Ref ref) {
  final FirebaseAuth auth = ref.watch(authProvider);
  return AuthService(auth);
});
