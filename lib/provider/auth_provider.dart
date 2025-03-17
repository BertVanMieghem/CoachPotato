import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<FirebaseAuth> authProvider = Provider<FirebaseAuth>((Ref ref) => FirebaseAuth.instance);

final StreamProvider<User?> authStateProvider = StreamProvider<User?>((Ref ref) {
  return ref.watch(authProvider).authStateChanges();
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

  Future<bool> sendSignInLink(String traineeEmail) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    ActionCodeSettings actionCodeSettings = ActionCodeSettings( // TODO config
      url: 'https://your-app-url.com/auth', // Your app's URL
      handleCodeInApp: true,
      iOSBundleId: 'com.coachpotato.app',
      androidPackageName: 'com.coachpotato.app',
      androidInstallApp: true,
      androidMinimumVersion: '21',
    );

    try {
      await auth.sendSignInLinkToEmail(
        email: traineeEmail,
        actionCodeSettings: actionCodeSettings,
      );
      return true;
    } catch (e) {
      return false;
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
