// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBe9TGI8ADOOml2e77Zd2pGIpfBbPV5xZQ',
    appId: '1:921637590617:web:564096d28c636be4fe4348',
    messagingSenderId: '921637590617',
    projectId: 'coach-potato',
    authDomain: 'coach-potato.firebaseapp.com',
    databaseURL: 'https://coach-potato-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'coach-potato.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlu427lTQDWjL6s7kGYQRp3tGpBNucguw',
    appId: '1:921637590617:android:804f471df124c4edfe4348',
    messagingSenderId: '921637590617',
    projectId: 'coach-potato',
    databaseURL: 'https://coach-potato-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'coach-potato.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNbddRPnm0cAo0g-VsrgfXURoN70f2zyk',
    appId: '1:921637590617:ios:1c6dc4f43913dd1afe4348',
    messagingSenderId: '921637590617',
    projectId: 'coach-potato',
    databaseURL: 'https://coach-potato-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'coach-potato.firebasestorage.app',
    iosClientId: '921637590617-2i04p823j06aqgfok9ioi4a1amvgq4kh.apps.googleusercontent.com',
    iosBundleId: 'com.example.coachPotato',
  );

}