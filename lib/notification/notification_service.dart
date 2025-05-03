import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_service/notification/notifiction_service_local.dart';

class NotificationServiceHelper {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static Future init() async {
    await requestNotificationPermission();
    getDeviceToken();
    FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
    // foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // show local notification
      NotifictionServiceLocal.showBasicNotification(message);
    });
    // all device in one topic
    messaging.subscribeToTopic('all').then((value) {
      print('sub topic success');
    });
  }

  static requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  static void getDeviceToken() async {
    try {
      messaging = FirebaseMessaging.instance;
      token = await messaging.getToken();

      log("device token : $token");
    } catch (e) {
      log('error notification : $e');
    }
  }

  static Future<void> handelBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? "null notification");
  }
}
