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
    apiKey: 'AIzaSyDZn6OI_duoVnh0mezdRRHymbQGPHShi5Y',
    appId: '1:331487908874:web:316897e5de5feabf37fbf3',
    messagingSenderId: '331487908874',
    projectId: 'rafeq-1e181',
    authDomain: 'rafeq-1e181.firebaseapp.com',
    storageBucket: 'rafeq-1e181.appspot.com',
    measurementId: 'G-E76C9ZJFZ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChOemRXBCyzzdpRC2odFhkBd9nvHPf_7w',
    appId: '1:331487908874:android:e753f7a0c5128c8737fbf3',
    messagingSenderId: '331487908874',
    projectId: 'rafeq-1e181',
    storageBucket: 'rafeq-1e181.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClHZaBU2NvYpHT-sIVchzrqi3VqG1mrDA',
    appId: '1:331487908874:ios:4b99a8d75fed179837fbf3',
    messagingSenderId: '331487908874',
    projectId: 'rafeq-1e181',
    storageBucket: 'rafeq-1e181.appspot.com',
    iosBundleId: 'com.example.rafeqApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClHZaBU2NvYpHT-sIVchzrqi3VqG1mrDA',
    appId: '1:331487908874:ios:3dbe92e74bfc97e637fbf3',
    messagingSenderId: '331487908874',
    projectId: 'rafeq-1e181',
    storageBucket: 'rafeq-1e181.appspot.com',
    iosBundleId: 'com.example.rafeqApp.RunnerTests',
  );
}
