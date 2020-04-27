import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:parks/common/root-store.dart';
import 'package:parks/routes.gr.dart';
import 'package:parks/transactions/transaction-model.dart';

class NotificationService {
  final fcm = FirebaseMessaging();
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'sendNotification',
  );

  StreamSubscription<IosNotificationSettings> iosSubscription;
  RootStore _root;

  NotificationService(this._root) {
    if (Platform.isIOS) {
      iosSubscription = fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (message) async {
        print("onMessage: $message");
        _handleMessage(message);
      },
      onLaunch: (message) async {
        print("onLaunch: $message");
        _handleMessage(message);
      },
      onResume: (message) async {
        print("onResume: $message");
        _handleMessage(message);
      },
    );
  }

  _handleMessage(Map<String, dynamic> message) async {
    final transaction = TransactionModel.fromJson(
      json.decode(message["data"]["transaction"]),
    );

    await _root.transactionStore.onTransactionMessage(transaction);

    ExtendedNavigator.rootNavigator.pushNamed(
      Routes.transactionDetail,
      arguments: TransactionPageArguments(transaction: transaction),
    );
  }

  Future<String> getToken() {
    return fcm.getToken();
  }

  Future testNotification(String plate, [int seconds]) async {
    String fcmToken = await fcm.getToken();

    String plate = "edede";

    String body = json.encode({
      "seconds": seconds,
      "token": fcmToken,
      "payload": {
        "data": {"plate": plate},
        "notification": {
          "title": "New transaction for $plate.",
          "body":
              "We have detected a car with plates $plate, open to accept the transaction.",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      }
    });

    final res = await post(
        "http://192.168.1.102:5000/webrtc-test-deb99/us-central1/sendNotification",
        body: body);

    print(res.body);
    print(res.statusCode);
    print(res.reasonPhrase);
  }
}
