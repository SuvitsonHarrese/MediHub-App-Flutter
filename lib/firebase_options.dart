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
    apiKey: 'AIzaSyCUCg9gneZkIBBRVc8-lYb4bJE_1QEgxd8',
    appId: '1:902645429143:web:5bfed53541863c9c484ad2',
    messagingSenderId: '902645429143',
    projectId: 'medihub-dfc57',
    authDomain: 'medihub-dfc57.firebaseapp.com',
    storageBucket: 'medihub-dfc57.appspot.com',
    measurementId: 'G-SVNK5S3CVG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5OZ7WGkUJsRJbcpXSGD7JSYlHt5T83n4',
    appId: '1:902645429143:android:e61ca88bf7f07b5d484ad2',
    messagingSenderId: '902645429143',
    projectId: 'medihub-dfc57',
    storageBucket: 'medihub-dfc57.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-P_ct4HEce6J2n_QNbox-OqtjuyWhDsA',
    appId: '1:902645429143:ios:a7f8e74699b8c8a1484ad2',
    messagingSenderId: '902645429143',
    projectId: 'medihub-dfc57',
    storageBucket: 'medihub-dfc57.appspot.com',
    iosClientId: '902645429143-jf6jj375kp33js2th14dgrum2k7la1tf.apps.googleusercontent.com',
    iosBundleId: 'com.example.medicineHub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-P_ct4HEce6J2n_QNbox-OqtjuyWhDsA',
    appId: '1:902645429143:ios:a7f8e74699b8c8a1484ad2',
    messagingSenderId: '902645429143',
    projectId: 'medihub-dfc57',
    storageBucket: 'medihub-dfc57.appspot.com',
    iosClientId: '902645429143-jf6jj375kp33js2th14dgrum2k7la1tf.apps.googleusercontent.com',
    iosBundleId: 'com.example.medicineHub',
  );
}