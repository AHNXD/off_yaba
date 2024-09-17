import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/employe/store_orders_screen.dart';
import 'package:off_yaba/services/cache_helper.dart';
import 'package:off_yaba/services/network/api_service.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'Highly Important Notifications',
    description: 'This Cahnnel is used for important nots',
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(StoreOrdersScreen.routeName);
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/off_yaba');

    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings);
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/off_yaba',
            autoCancel: true,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> saveToken() async {
    final bool? hasToken = await CacheHelper.getData(key: "hasFCMToken");
    log(hasToken.toString());
    final fCMToken = await _firebaseMessaging.getToken();
    final String? token = await CacheHelper.getData(key: "token");
    if (token != null) {
      if (hasToken == null || !hasToken) {
        try {
          final String? userType = await CacheHelper.getData(key: "userType");
          await DioHelper.postAuthorized(
              path: '/$userType/add-fcm-token',
              data: {
                "token": fCMToken,
              });
          await CacheHelper.setBool(key: "hasFCMToken", value: true);
        } on DioException {}
      }
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? userType = CacheHelper.getData(key: "userType");
    if (userType != null) {
      await _firebaseMessaging.subscribeToTopic(userType);
    }
    await saveToken();
    await initPushNotifications();
    await initLocalNotifications();
  }
}
