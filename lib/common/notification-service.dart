import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final fcm = FirebaseMessaging();

  StreamSubscription<IosNotificationSettings> iosSubscription;

  NotificationService() {
    if (Platform.isIOS) {
      iosSubscription = fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: (message) async {
        print("onBackgroundMessage: $message");
      },
      onLaunch: (message) async {
        print("onLaunch: $message");
      },
      onResume: (message) async {
        print("onResume: $message");
      },
    );
  }

  Future<String> _saveDeviceToken() async {
    // Get the current user
    String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await fcm.getToken();

    // Save it to Firestore
    // if (fcmToken != null) {
    //   var tokens = _db
    //       .collection('users')
    //       .document(uid)
    //       .collection('tokens')
    //       .document(fcmToken);

    //   await tokens.setData({
    //     'token': fcmToken,
    //     'createdAt': FieldValue.serverTimestamp(), // optional
    //     'platform': Platform.operatingSystem // optional
    //   });
    // }
    return fcmToken;
  }
}
