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
    apiKey: 'AIzaSyAEZWnInWLWU5yqG7Y1NyKkQSon_RRxWNY',
    appId: '1:192909855910:web:f50aa440ac666be3873867',
    messagingSenderId: '192909855910',
    projectId: 'hackgt2023',
    authDomain: 'hackgt2023.firebaseapp.com',
    storageBucket: 'hackgt2023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATxM_RUX_OreCB3ftyZaI2ByYNNZTRqm4',
    appId: '1:192909855910:android:a3092489a70c4c20873867',
    messagingSenderId: '192909855910',
    projectId: 'hackgt2023',
    storageBucket: 'hackgt2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAecUFC5dEESq3rLDNNx-Kxx0_w5sZvWGs',
    appId: '1:192909855910:ios:4a2fec003c262c61873867',
    messagingSenderId: '192909855910',
    projectId: 'hackgt2023',
    storageBucket: 'hackgt2023.appspot.com',
    iosBundleId: 'com.example.wattWizard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAecUFC5dEESq3rLDNNx-Kxx0_w5sZvWGs',
    appId: '1:192909855910:ios:a49a650b4f8915ac873867',
    messagingSenderId: '192909855910',
    projectId: 'hackgt2023',
    storageBucket: 'hackgt2023.appspot.com',
    iosBundleId: 'com.example.wattWizard.RunnerTests',
  );
}
