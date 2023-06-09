import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbh3phl587OA27ebU1u3bI4jGzDLkpKtk',
    appId: '1:781078940601:android:66d06b59255155f4b48468',
    messagingSenderId: '781078940601',
    projectId: 'r5-task-list',
    storageBucket: 'r5-task-list.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHt_eSMboB1ZRu16VvbGpDpNlLS26XY0w',
    appId: '1:781078940601:ios:ffb47550305d5fceb48468',
    messagingSenderId: '781078940601',
    projectId: 'r5-task-list',
    storageBucket: 'r5-task-list.appspot.com',
    iosClientId: '781078940601-uloup7egv18rfsusmnnm5vt9ejavvgde.apps.googleusercontent.com',
    iosBundleId: 'com.example.r5TaskList',
  );
}