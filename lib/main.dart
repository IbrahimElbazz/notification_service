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
      home: HomePage(), // Wrap the initial page in a Navigator
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Token Screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TokenScreen()),
            );
          },
        ),
      ),
    );
  }
}

class TokenScreen extends StatelessWidget {
  const TokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(NotificationServiceHelper.token ?? "")),
    );
  }
}
