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
    apiKey: 'AIzaSyDaZoQBA-puPTRud5Ww2BTfgURt734Ihy4',
    appId: '1:479274730269:web:1ebe8694f29a19d01797f4',
    messagingSenderId: '479274730269',
    projectId: 'bean-fast',
    authDomain: 'bean-fast.firebaseapp.com',
    storageBucket: 'bean-fast.appspot.com',
    measurementId: 'G-GBZG21KFBD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzFsTVQ-6davocW6ZT3VNFcmMEIRG0IVQ',
    appId: '1:479274730269:android:e143b89ce6aed2ad1797f4',
    messagingSenderId: '479274730269',
    projectId: 'bean-fast',
    storageBucket: 'bean-fast.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcYuOK4ELAK5IsfwpaiglUHX71RcHnBsw',
    appId: '1:479274730269:ios:88afeb4171a4b8c61797f4',
    messagingSenderId: '479274730269',
    projectId: 'bean-fast',
    storageBucket: 'bean-fast.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcYuOK4ELAK5IsfwpaiglUHX71RcHnBsw',
    appId: '1:479274730269:ios:88afeb4171a4b8c61797f4',
    messagingSenderId: '479274730269',
    projectId: 'bean-fast',
    storageBucket: 'bean-fast.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDaZoQBA-puPTRud5Ww2BTfgURt734Ihy4',
    appId: '1:479274730269:web:f2ba4f21bd0e116f1797f4',
    messagingSenderId: '479274730269',
    projectId: 'bean-fast',
    authDomain: 'bean-fast.firebaseapp.com',
    storageBucket: 'bean-fast.appspot.com',
    measurementId: 'G-N2RTW2PHTV',
  );
}
