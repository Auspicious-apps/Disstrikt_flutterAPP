import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
    apiKey: 'AIzaSyAe9XHrz-FBdKLDl3uD5XD13bltFtKBVGs',
    appId: '1:48002840638:web:36dcf9c2c37104d4ccb96f',
    messagingSenderId: '48002840638',
    projectId: 'play-app-9c4df',
    authDomain: 'play-app-9c4df.firebaseapp.com',
    storageBucket: 'play-app-9c4df.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJeWu-yf3YRh5fBXMC01oei4O_lZQZsEE',
    appId: '1:144224789471:android:8b8f287286fa121d4c1a6a',
    messagingSenderId: '144224789471',
    projectId: 'disstriktapp',
    storageBucket: 'disstriktapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAe9XHrz-FBdKLDl3uD5XD13bltFtKBVGs',
    appId: '1:48002840638:ios:36dcf9c2c37104d4ccb96f',
    messagingSenderId: '48002840638',
    projectId: 'play-app-9c4df',
    storageBucket: 'play-app-9c4df.firebasestorage.app',
    iosClientId:
        '48002840638-muij1uqvo6867lpp7qk97gk5q494p2k6.apps.googleusercontent.com',
    iosBundleId: 'com.aus.org.badminton',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAe9XHrz-FBdKLDl3uD5XD13bltFtKBVGs',
    appId: '1:48002840638:ios:36dcf9c2c37104d4ccb96f',
    messagingSenderId: '48002840638',
    projectId: 'play-app-9c4df',
    storageBucket: 'play-app-9c4df.firebasestorage.app',
    iosClientId:
        '48002840638-muij1uqvo6867lpp7qk97gk5q494p2k6.apps.googleusercontent.com',
    iosBundleId: 'com.aus.org.badminton',
  );
}
