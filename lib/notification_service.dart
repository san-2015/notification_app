import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // 👈 custom icon

    const InitializationSettings settings = InitializationSettings(
      android: androidInit,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // 👇 handle actions when notification is tapped
        if (response.payload != null) {
          print("User tapped notification with payload: ${response.payload}");
        }
      },
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'chat_channel', // channel id
      'Chat Notifications', // channel name
      channelDescription: 'Notification channel for chat app',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      // sound: RawResourceAndroidNotificationSound('custom_sound'), // 👈 custom sound
      icon: '@mipmap/ic_launcher', // 👈 custom icon
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: payload,
    );
  }
}
