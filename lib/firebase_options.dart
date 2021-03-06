// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALXW4um2pCMTrsWxfMMhIST5-b9Xp4mPs',
    appId: '1:921110513710:web:fc07970c53a1f3890f37bf',
    messagingSenderId: '921110513710',
    projectId: 'zazen-release',
    authDomain: 'zazen-release.firebaseapp.com',
    storageBucket: 'zazen-release.appspot.com',
    measurementId: 'G-S3H097JMT0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtlryI3WfOiXq9F5tsINo_CwEBPVSx6NY',
    appId: '1:921110513710:android:c0efdd648c6ea3890f37bf',
    messagingSenderId: '921110513710',
    projectId: 'zazen-release',
    storageBucket: 'zazen-release.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCc9iQQ-ifkWRHRaS3M-U3b1mzBFX5-LA0',
    appId: '1:921110513710:ios:ac1a36becce924c20f37bf',
    messagingSenderId: '921110513710',
    projectId: 'zazen-release',
    storageBucket: 'zazen-release.appspot.com',
    iosClientId: '921110513710-caj0oqhk80eijr42b7c4sgcv56jcd7gs.apps.googleusercontent.com',
    iosBundleId: 'com.zazen.release',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCc9iQQ-ifkWRHRaS3M-U3b1mzBFX5-LA0',
    appId: '1:921110513710:ios:ac1a36becce924c20f37bf',
    messagingSenderId: '921110513710',
    projectId: 'zazen-release',
    storageBucket: 'zazen-release.appspot.com',
    iosClientId: '921110513710-caj0oqhk80eijr42b7c4sgcv56jcd7gs.apps.googleusercontent.com',
    iosBundleId: 'com.zazen.release',
  );
}
