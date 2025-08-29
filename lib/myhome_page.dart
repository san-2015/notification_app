import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.instance.subscribeToTopic("codewithsan");
    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.title);
      print(message.notification!.body.toString());
      NotificationService.showNotification(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        payload: message.data['route'],
      );
    });

    // When app opened by tapping notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened: ${message.notification?.title}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FCM Demo"),
      ),
      body: Center(
        child: Text("Listening for notifications..."),
      ),
    );
  }
}
