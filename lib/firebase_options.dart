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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD0DPQNoI6zMQSLD4FVbhaEIrXtIRh7uXY',
    appId: '1:976390450804:web:00829dbaf99eac18d72b21',
    messagingSenderId: '976390450804',
    projectId: 'flutterappcall',
    authDomain: 'flutterappcall.firebaseapp.com',
    storageBucket: 'flutterappcall.appspot.com',
    measurementId: 'G-SYQP0N5HYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgik8jlT8hyxWLQVOTHkYQq4Xx4yV4o7E',
    appId: '1:976390450804:android:3cbba4709cb1bbaad72b21',
    messagingSenderId: '976390450804',
    projectId: 'flutterappcall',
    storageBucket: 'flutterappcall.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAd5_KW9279zDynUBocXVdCl9VSc170lC4',
    appId: '1:976390450804:ios:78d7042f34fe0907d72b21',
    messagingSenderId: '976390450804',
    projectId: 'flutterappcall',
    storageBucket: 'flutterappcall.appspot.com',
    iosBundleId: 'com.example.myProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAd5_KW9279zDynUBocXVdCl9VSc170lC4',
    appId: '1:976390450804:ios:78d7042f34fe0907d72b21',
    messagingSenderId: '976390450804',
    projectId: 'flutterappcall',
    storageBucket: 'flutterappcall.appspot.com',
    iosBundleId: 'com.example.myProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0DPQNoI6zMQSLD4FVbhaEIrXtIRh7uXY',
    appId: '1:976390450804:web:22c88ecb6761d2a8d72b21',
    messagingSenderId: '976390450804',
    projectId: 'flutterappcall',
    authDomain: 'flutterappcall.firebaseapp.com',
    storageBucket: 'flutterappcall.appspot.com',
    measurementId: 'G-M9YGX8RVNE',
  );
}
