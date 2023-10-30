// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:lokal/main.dart';
//
// class NotificationController {
//   static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//     print('"SilentData": ${silentData.toString()}');
//
//     // if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
//     //   print("bg");
//     // } else {
//     //   print("FOREGROUND");
//     // }
//
//     await Future.delayed(Duration(seconds: 4));
//     final url = Uri.parse("http://google.com");
//     final re = await http.get(url);
//     print(re.body);
//     print("long task done");
//   }
//
//   /// Use this method to detect when a new fcm token is received
//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     debugPrint('FCM Token:"$token"');
//   }
//
//   /// Use this method to detect when a new native token is received
//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     debugPrint('Native Token:"$token"');
//   }
//
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//
//     // Navigate into pages, avoiding to open the notification details page over another details page already opened
//     LokalApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
//         '/notification-page',
//         (route) =>
//             (route.settings.name != '/notification-page') || route.isFirst,
//         arguments: receivedAction);
//   }
// }

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';

class FirebaseMessagingController {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChanel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notification',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');
    }
    var kFcmToken = await _firebaseMessaging.getToken();

    print('________FCM1_______');
    print(kFcmToken);
    print('________FCM1 ENDS_______');

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      kFcmToken = fcmToken;
      print('________FCM2_______');
      print(kFcmToken);
      print('________FCM2 ENDS_______');
    }).onError((err) {
      print("error");
      throw Exception(err);
    });

    if (kFcmToken!.isNotEmpty) saveFCMForUser(kFcmToken!);
    initPushNotifications();
    initLocalNotification();
  }

  void handleMessageTap(RemoteMessage? message) {
    if (message == null) return;
    //todo handle navigation
    print('_________Notification tapped________');
    NavigationUtils.openScreen(ScreenRoutes.myAccountScreen);
    //todo set url by notification!
    // DeeplinkHandler.openPage(
    //     AppRoutes.rootNavigatorKey.currentContext, message.data['URL']);
  }

  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _firebaseMessaging.getInitialMessage().then(handleMessageTap);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageTap);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              _androidChanel.id, _androidChanel.name,
              channelDescription: _androidChanel.description,
              icon: '@drawable/ic_launcher'),
        ),
        payload: jsonEncode(
          event.toMap(),
        ),
      );
    });
  }

  Future initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const anddroid = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(android: anddroid, iOS: ios);

    await _localNotification.initialize(setting,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessageTap(message);
    });
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChanel);
  }

  Future<void> saveFCMForUser(String fcmToken) async {
    await ApiRepository.saveNotificationToken(
        ApiRequestBody.getNotificationAddUserDetailsRequest(fcmToken, FCM));
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('______________-laaaaaaaaaa-_____________');
  print('Handling a background message: ${message.messageId}');
  print(message.data);
  print(message.notification?.body ?? '');
}
