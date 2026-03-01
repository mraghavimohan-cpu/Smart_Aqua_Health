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
    apiKey: 'AIzaSyA7WBlTJS_xUraNYCNqucOJ60l2idnRZmw',
    appId: '1:538025531981:web:42958fa644cd4ff4205a04',
    messagingSenderId: '538025531981',
    projectId: 'smart-aqua-abc9d',
    storageBucket: 'smart-aqua-abc9d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7WBlTJS_xUraNYCNqucOJ60l2idnRZmw',
    appId: '1:538025531981:android:42958fa644cd4ff4205a04',
    messagingSenderId: '538025531981',
    projectId: 'smart-aqua-abc9d',
    storageBucket: 'smart-aqua-abc9d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7WBlTJS_xUraNYCNqucOJ60l2idnRZmw',
    appId: '1:538025531981:ios:42958fa644cd4ff4205a04',
    messagingSenderId: '538025531981',
    projectId: 'smart-aqua-abc9d',
    storageBucket: 'smart-aqua-abc9d.firebasestorage.app',
    iosBundleId: 'com.example.Smart_Aqua',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7WBlTJS_xUraNYCNqucOJ60l2idnRZmw',
    appId: '1:538025531981:ios:42958fa644cd4ff4205a04',
    messagingSenderId: '538025531981',
    projectId: 'smart-aqua-abc9d',
    storageBucket: 'smart-aqua-abc9d.firebasestorage.app',
    iosBundleId: 'com.example.Smart_Aqua',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA7WBlTJS_xUraNYCNqucOJ60l2idnRZmw',
    appId: '1:538025531981:web:42958fa644cd4ff4205a04',
    messagingSenderId: '538025531981',
    projectId: 'smart-aqua-abc9d',
    authDomain: 'smart-aqua-abc9d.firebaseapp.com',
    storageBucket: 'smart-aqua-abc9d.firebasestorage.app',
  );
}
