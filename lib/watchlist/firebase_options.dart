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
    apiKey: 'AIzaSyAefqsMDTr-_EMxMayqo_3iU6jKl5Hdsgc',
    appId: '1:496168796561:web:717c0ffd3c79d12a521a30',
    messagingSenderId: '496168796561',
    projectId: 'movie-fa057',
    authDomain: 'movie-fa057.firebaseapp.com',
    storageBucket: 'movie-fa057.appspot.com',
    measurementId: 'G-BGYP17QNQ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJki_DgaH8VVq3nv34MmD5wvh7JLQr_xk',
    appId: '1:496168796561:android:23f1989f296d62eb521a30',
    messagingSenderId: '496168796561',
    projectId: 'movie-fa057',
    storageBucket: 'movie-fa057.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCo4VqLhhgoGmpRMVPHo6_KhR9rbjPct6I',
    appId: '1:496168796561:ios:178dc1f4664c93d4521a30',
    messagingSenderId: '496168796561',
    projectId: 'movie-fa057',
    storageBucket: 'movie-fa057.appspot.com',
    iosBundleId: 'com.example.untitled18',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCo4VqLhhgoGmpRMVPHo6_KhR9rbjPct6I',
    appId: '1:496168796561:ios:178dc1f4664c93d4521a30',
    messagingSenderId: '496168796561',
    projectId: 'movie-fa057',
    storageBucket: 'movie-fa057.appspot.com',
    iosBundleId: 'com.example.untitled18',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAefqsMDTr-_EMxMayqo_3iU6jKl5Hdsgc',
    appId: '1:496168796561:web:3bc3bbe179d2d0c2521a30',
    messagingSenderId: '496168796561',
    projectId: 'movie-fa057',
    authDomain: 'movie-fa057.firebaseapp.com',
    storageBucket: 'movie-fa057.appspot.com',
    measurementId: 'G-XHND6DP8E5',
  );
}
