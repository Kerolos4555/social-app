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
    apiKey: 'AIzaSyAduCW15MIoId9bZ7ZxaM8le2J3ObrL0jw',
    appId: '1:52082074771:web:8ace9bce05ce790d14d966',
    messagingSenderId: '52082074771',
    projectId: 'socialapp-1587e',
    authDomain: 'socialapp-1587e.firebaseapp.com',
    storageBucket: 'socialapp-1587e.appspot.com',
    measurementId: 'G-G0QXPWEF2N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB640FNOx-2sANLdTltnf6MRybMXAM55Q0',
    appId: '1:52082074771:android:03048a246e0ade1614d966',
    messagingSenderId: '52082074771',
    projectId: 'socialapp-1587e',
    storageBucket: 'socialapp-1587e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJdHezdLOWKtbzUjU5xovaUaR3Ximw0XM',
    appId: '1:52082074771:ios:4ba40dc9faab2d1b14d966',
    messagingSenderId: '52082074771',
    projectId: 'socialapp-1587e',
    storageBucket: 'socialapp-1587e.appspot.com',
    iosBundleId: 'com.example.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJdHezdLOWKtbzUjU5xovaUaR3Ximw0XM',
    appId: '1:52082074771:ios:9e67a90b7d340c3214d966',
    messagingSenderId: '52082074771',
    projectId: 'socialapp-1587e',
    storageBucket: 'socialapp-1587e.appspot.com',
    iosBundleId: 'com.example.socialApp.RunnerTests',
  );
}
