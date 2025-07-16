import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static const String androidClientId =
      '144224789471-3h4o77lmvpsv2j446drikuevr5kvelar.apps.googleusercontent.com';
  static const String iosClientId =
      '144224789471-872scl2l4ips2gql8qe5dc3vgm0v9im7.apps.googleusercontent.com'; // Replace with iOS Client ID from GoogleService-Info.plist

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyAe9XHrz-FBdKLDl3uD5XD13bltFtKBVGs',
  //   appId: '1:48002840638:web:36dcf9c2c37104d4ccb96f',
  //   messagingSenderId: '48002840638',
  //   projectId: 'play-app-9c4df',
  //   authDomain: 'play-app-9c4df.firebaseapp.com',
  //   storageBucket: 'play-app-9c4df.firebasestorage.app',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJeWu-yf3YRh5fBXMC01oei4O_lZQZsEE',
    appId: '1:144224789471:android:8b8f287286fa121d4c1a6a',
    messagingSenderId: '144224789471',
    projectId: 'disstriktapp',
    storageBucket: 'disstriktapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey:
        'AIzaSyBWmJQQLZjeSWX-vQueCyQh-90B6TvG32A', // From GoogleService-Info.plist
    appId:
        '1:144224789471:ios:8b8058693a5974aa4c1a6a', // From GoogleService-Info.plist
    messagingSenderId: '144224789471', // From GoogleService-Info.plist
    projectId: 'disstriktapp', // From GoogleService-Info.plist
    storageBucket:
        'disstriktapp.firebasestorage.app', // From GoogleService-Info.plist
    iosClientId:
        '144224789471-872scl2l4ips2gql8qe5dc3vgm0v9im7.apps.googleusercontent.com', // From GoogleService-Info.plist
    iosBundleId: 'com.aus.disttrikt', // From GoogleService-Info.plist
  );
}
