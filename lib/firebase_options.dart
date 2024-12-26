import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
///
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey:
        'AIzaSyClHAtSR0wBF67gBbBWGkkcIzoF8J_UGts', // Remplacer avec votre API key
    appId:
        '1:546765730114:web:accdbe32d58ac543bdc9d2', // Remplacer avec votre App ID
    messagingSenderId:
        '546765730114', // Remplacer avec votre Messaging Sender ID
    projectId: 'fir-app-34396', // Remplacer avec votre Project ID
    authDomain:
        'fir-app-34396.firebaseapp.com', // Remplacer avec votre Auth Domain
    storageBucket:
        'fir-app-34396.firebasestorage.app', // Remplacer avec votre Storage Bucket
    measurementId: 'G-FVTFSVGWHJ', // Remplacer avec votre Measurement ID
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey:
        'AIzaSyClHAtSR0wBF67gBbBWGkkcIzoF8J_UGts', // Remplacer avec votre API key
    appId:
        '1:546765730114:android:67e493e924c0620a38d8db', // Remplacer avec votre App ID
    messagingSenderId:
        '546765730114', // Remplacer avec votre Messaging Sender ID
    projectId: 'fir-app-34396', // Remplacer avec votre Project ID
    storageBucket:
        'fir-app-34396.firebasestorage.app', // Remplacer avec votre Storage Bucket
  );
}
