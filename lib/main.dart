import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notification_service/firebase_options.dart';
import 'package:notification_service/notification/notification_service.dart';
import 'package:notification_service/notification/notifiction_service_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationServiceHelper.init();
  NotifictionServiceLocal.init();
  runApp(const NotificationService());
}

class NotificationService extends StatelessWidget {
  const NotificationService({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text(NotificationServiceHelper.token ?? "")),
      ),
    );
  }
}
