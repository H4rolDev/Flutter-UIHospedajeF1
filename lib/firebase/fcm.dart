import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class fcmAdapter{
  static Future<NotificationSettings> initialize() async {
    final fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: "BKag");
    print('FCM Token: $fcmToken');

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission ${settings.authorizationStatus}');
    return settings;
  }

  static void startGetMessages() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  } 
}