// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'modal_service.dart';

Future<void> listener() async {
  await createNotificationChannel();

  FirebaseMessaging.instance.requestPermission();

  FirebaseMessaging.instance.getToken().then((value) async => {
        print('Device token: $value'),
        await FirebaseMessaging.instance.subscribeToTopic('test-topic')
      });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');

    if (message.notification?.body != null) {
      ModalService.showModal(message.notification!.body!);
    } else {
      print('Foreground message data: ${message.data}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification?.body != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ModalService.showModal(message.notification!.body!));
    }
  });

  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  print('Got a message whilst in the background!');
  print('Background message data: ${message.data}');
  if (message.notification != null) {
    print('Background message also contained a notification: ${message.notification?.body}');
  }
}

Future<void> createNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
