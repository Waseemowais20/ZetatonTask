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
    apiKey: 'AIzaSyDFlKItwFq1a2YqQ-Pfh2JOtNGV1DxlFTI',
    appId: '1:497322845305:web:1c59a3145ad99e1874e0a8',
    messagingSenderId: '497322845305',
    projectId: 'zetatontask-a58f2',
    authDomain: 'zetatontask-a58f2.firebaseapp.com',
    storageBucket: 'zetatontask-a58f2.appspot.com',
    measurementId: 'G-27H8NM1J83',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8BEdPUovGk8ZiG_qozuihfyoaR0hBYlo',
    appId: '1:497322845305:android:7ca6a5fe6df71b1974e0a8',
    messagingSenderId: '497322845305',
    projectId: 'zetatontask-a58f2',
    storageBucket: 'zetatontask-a58f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBURni-xl9f3RbcvK5vjjojLj8H8HDc-ng',
    appId: '1:497322845305:ios:390ab512ced3087374e0a8',
    messagingSenderId: '497322845305',
    projectId: 'zetatontask-a58f2',
    storageBucket: 'zetatontask-a58f2.appspot.com',
    iosBundleId: 'com.example.zetatonTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBURni-xl9f3RbcvK5vjjojLj8H8HDc-ng',
    appId: '1:497322845305:ios:3f760bd5853e5bd074e0a8',
    messagingSenderId: '497322845305',
    projectId: 'zetatontask-a58f2',
    storageBucket: 'zetatontask-a58f2.appspot.com',
    iosBundleId: 'com.example.zetatonTask.RunnerTests',
  );
}
