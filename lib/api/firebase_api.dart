import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("title :${message.notification?.title}");
  debugPrint("body :${message.notification?.body}");
  debugPrint("payload :${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("TOKEN :$fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}


