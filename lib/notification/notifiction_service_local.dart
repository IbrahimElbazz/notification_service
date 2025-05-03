import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotifictionServiceLocal {
  static final Random random = Random();
  static int generateRandomId() {
    return random.nextInt(10000); // توليد رقم عشوائي بين 0 و 9999
  }

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future<void> init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  // basic notification
  static void showBasicNotification(RemoteMessage message) async {
    // display image in local notification
    final http.Response image = await http.get(
      Uri.parse(
        message.notification?.android?.imageUrl ?? "",
      ),
    );
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(
          image.bodyBytes,
        ),
      ),
    );

    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails('id 1', 'basic notification',
          // display notification in app & when create one time don't display we must clear storage app in info app
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigPictureStyleInformation),
    );
    await flutterLocalNotificationsPlugin.show(
      generateRandomId(),
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }
}
