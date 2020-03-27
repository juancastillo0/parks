import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/user-parking/user-model.dart';

class NotificationService {
  final fcm = FirebaseMessaging();
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'sendPlateNotification',
  );

  StreamSubscription<IosNotificationSettings> iosSubscription;

  NotificationService(String plate) {
    // if (Platform.isIOS) {
    //   iosSubscription = fcm.onIosSettingsRegistered.listen((data) {
    //     // save the token  OR subscribe to a topic here
    //   });

    //   fcm.requestNotificationPermissions(IosNotificationSettings());
    // }

    fcm.configure(
      onMessage: (message) async {
        print("onMessage: $message");
      },
      onLaunch: (message) async {
        print("onLaunch: $message");
      },
      onResume: (message) async {
        print("onResume: $message");
        ExtendedNavigator.rootNavigator.pushNamed(Routes.transactionDetail,
            arguments: TransactionPageArguments(
                transaction: allUsers[0].transactions[0]));
      },
    );
    subscribeToTopic(plate);
    // testNotification(plate, 5);
  }

  Future subscribeToTopic(String plate) async {
    String fcmToken = await fcm.getToken();
    print(fcmToken);

    // await fcm.subscribeToTopic(plate);
  }

  Future testNotification(String plate, [int seconds]) async {
    String fcmToken = await fcm.getToken();
    final res = await post(
        "https://us-central1-webrtc-test-deb99.cloudfunctions.net/sendPlateNotification",
        body: '{"plate": "$plate", "seconds": $seconds, "token": "$fcmToken"}');
    print(res);
    // callable.call();
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
