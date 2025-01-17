import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_firebase/firebase_messaging/custom_local_notification.dart';
import 'package:projeto_firebase/main.dart';

class CustomFirebaseMessaging {
  final CustomLocalNotification _customLocalNotification;

  /// Construtor privado; o nome "_internal" não é obrigatório
  CustomFirebaseMessaging._internal(this._customLocalNotification);

  static final CustomFirebaseMessaging _singleton =
      CustomFirebaseMessaging._internal(CustomLocalNotification());
  factory CustomFirebaseMessaging() => _singleton;

  Future<void> initialize(VoidCallback? callback) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (message.data["forceFetch"] != null) {
        print("Ei!! aaaaa");
        callback?.call();
        return; // para o usuário sequer receber a notificação
      }

      if (notification != null && android != null) {
        _customLocalNotification.androidNotification(notification, android);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data["goTO"] != null) {
        navigatorKey.currentState?.pushNamed(message.data["goTO"]);
      }
    });
  }

  getTokenFirebase() async =>
      debugPrint(await FirebaseMessaging.instance.getToken());
}
