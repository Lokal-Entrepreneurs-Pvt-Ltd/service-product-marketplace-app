// import 'dart:developer';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:lokal/notifications/notification_controller.dart';
//
// class FireTest extends StatefulWidget {
//   FireTest({super.key});
//
//   @override
//   State<FireTest> createState() => _FireTestState();
// }
//
// class _FireTestState extends State<FireTest> {
//   @override
//   void initState() {
//     super.initState();
//     AwesomeNotifications().setListeners(
//         onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//         onNotificationCreatedMethod:
//             NotificationController.onNotificationCreatedMethod,
//         onNotificationDisplayedMethod:
//             NotificationController.onNotificationDisplayedMethod,
//         onDismissActionReceivedMethod:
//             NotificationController.onDismissActionReceivedMethod);
//   }
//
//   Future<String> getFirebaseMessagingToken() async {
//     String firebaseAppToken = '';
//     if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
//       try {
//         firebaseAppToken =
//             await AwesomeNotificationsFcm().requestFirebaseAppToken();
//         log(firebaseAppToken.toString());
//       } catch (exception) {
//         debugPrint('$exception');
//       }
//     } else {
//       debugPrint('Firebase is not available on this project');
//     }
//     return firebaseAppToken;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//               child: Text("data"), onPressed: getFirebaseMessagingToken
//               )),
//     );
//   }
// }

// _________________Awesome_Notification_Fcm implementation_________________

// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:lokal/constants/json_constants.dart';
// import 'package:lokal/main.dart';
// import 'package:lokal/utils/network/ApiRepository.dart';
// import 'package:lokal/utils/network/ApiRequestBody.dart';
//
// class NotificationController extends ChangeNotifier {
//   /// *********************************************
//   ///   SINGLETON PATTERN
//   /// *********************************************
//
//   static final NotificationController _instance =
//   NotificationController._internal();
//
//   factory NotificationController() {
//     return _instance;
//   }
//
//   NotificationController._internal();
//
//   /// *********************************************
//   ///  OBSERVER PATTERN
//   /// *********************************************
//
//   String _firebaseToken = '';
//
//   String get firebaseToken => _firebaseToken;
//
//   String _nativeToken = '';
//
//   String get nativeToken => _nativeToken;
//
//   ReceivedAction? initialAction;
//
//   /// *********************************************
//   ///   INITIALIZATION METHODS
//   /// *********************************************
//
//   static Future<void> initializeLocalNotifications(
//       {required bool debug}) async {
//     await AwesomeNotifications().initialize(
//       null, //'resource://drawable/res_app_icon',//
//       [
//         NotificationChannel(
//             channelKey: 'alerts',
//             channelName: 'Alerts',
//             channelDescription: 'Notification tests as alerts',
//             playSound: true,
//             importance: NotificationImportance.High,
//             defaultPrivacy: NotificationPrivacy.Private,
//             defaultColor: Colors.deepPurple,
//             ledColor: Colors.deepPurple)
//       ],
//       debug: debug,
//       languageCode: 'en',
//     );
//
//     // Get initial notification action is optional
//     _instance.initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }
//
//   static Future<void> initializeRemoteNotifications(
//       {required bool debug}) async {
//     await Firebase.initializeApp();
//     await AwesomeNotificationsFcm().initialize(
//       onFcmTokenHandle: NotificationController.myFcmTokenHandle,
//       // onNativeTokenHandle: NotificationController.myNativeTokenHandle,
//       onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
//       // On this example app, the app ID / Bundle Id are different
//       // for each platform, so i used the main Bundle ID + 1 variation
//       licenseKeys:
//       // On this example app, the app ID / Bundle Id are different
//       // for each platform, so i used the main Bundle ID + 1 variation
//       [
//         // me.carda.awesomeNotificationsFcmExample
//         'B3J3yxQbzzyz0KmkQR6rDlWB5N68sTWTEMV7k9HcPBroUh4RZ/Og2Fv6Wc/lE'
//             '2YaKuVY4FUERlDaSN4WJ0lMiiVoYIRtrwJBX6/fpPCbGNkSGuhrx0Rekk'
//             '+yUTQU3C3WCVf2D534rNF3OnYKUjshNgQN8do0KAihTK7n83eUD60=',
//
//         // me.carda.awesome_notifications_fcm_example
//         'UzRlt+SJ7XyVgmD1WV+7dDMaRitmKCKOivKaVsNkfAQfQfechRveuKblFnCp4'
//             'zifTPgRUGdFmJDiw1R/rfEtTIlZCBgK3Wa8MzUV4dypZZc5wQIIVsiqi0Zhaq'
//             'YtTevjLl3/wKvK8fWaEmUxdOJfFihY8FnlrSA48FW94XWIcFY=',
//       ],
//       debug: debug,
//     );
//   }
//
//   static Future<void> startListeningNotificationEvents() async {
//     AwesomeNotifications()
//         .setListeners(onActionReceivedMethod: onActionReceivedMethod);
//   }
//
//   static ReceivePort? receivePort;
//
//   static Future<void> initializeIsolateReceivePort() async {
//     receivePort = ReceivePort('Notification action port in main isolate')
//       ..listen(
//               (silentData) => onActionReceivedImplementationMethod(silentData));
//
//     IsolateNameServer.registerPortWithName(
//         receivePort!.sendPort, 'notification_action_port');
//   }
//
//   ///  *********************************************
//   ///     LOCAL NOTIFICATION EVENTS
//   ///  *********************************************
//
//   static Future<void> getInitialNotificationAction() async {
//     ReceivedAction? receivedAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: true);
//     if (receivedAction == null) return;
//
//     // Fluttertoast.showToast(
//     //     msg: 'Notification action launched app: $receivedAction',
//     //   backgroundColor: Colors.deepPurple
//     // );
//     print('App launched by a notification action: $receivedAction');
//   }
//
//   @pragma('vm:entry-point')
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     if (receivedAction.actionType == ActionType.SilentAction ||
//         receivedAction.actionType == ActionType.SilentBackgroundAction) {
//       // For background actions, you must hold the execution until the end
//       print(
//           'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
//       await executeLongTaskInBackground();
//       return;
//     } else {
//       if (receivePort == null) {
//         // onActionReceivedMethod was called inside a parallel dart isolate.
//         SendPort? sendPort =
//         IsolateNameServer.lookupPortByName('notification_action_port');
//
//         if (sendPort != null) {
//           // Redirecting the execution to main isolate process (this process is
//           // only necessary when you need to redirect the user to a new page or
//           // use a valid context)
//           sendPort.send(receivedAction);
//           return;
//         }
//       }
//     }
//
//     return onActionReceivedImplementationMethod(receivedAction);
//   }
//
//   static Future<void> onActionReceivedImplementationMethod(
//       ReceivedAction receivedAction) async {}
//
//   ///  *********************************************
//   ///     REMOTE NOTIFICATION EVENTS
//   ///  *********************************************
//
//   /// Use this method to execute on background when a silent data arrives
//   /// (even while terminated)
//   @pragma("vm:entry-point")
//   static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//     Fluttertoast.showToast(
//         msg: 'Silent data received',
//         backgroundColor: Colors.blueAccent,
//         textColor: Colors.white,
//         fontSize: 16);
//
//     print('"SilentData": ${silentData.toString()}');
//
//     if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
//       print("bg");
//     } else {
//       print("FOREGROUND");
//     }
//
//     print('mySilentDataHandle received a FcmSilentData execution');
//     await executeLongTaskInBackground();
//   }
//
//   /// Use this method to detect when a new fcm token is received
//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     if (token.isNotEmpty) {
//       await saveFCMForUser(token);
//
//       debugPrint('Firebase Token:"$token"');
//     } else {
//       Fluttertoast.showToast(
//           msg: 'Fcm token deleted',
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16);
//
//       debugPrint('Firebase Token deleted');
//     }
//
//     _instance._firebaseToken = token;
//     _instance.notifyListeners();
//   }
//
//   /// Use this method to detect when a new native token is received
//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     Fluttertoast.showToast(
//         msg: 'Native token received',
//         backgroundColor: Colors.blueAccent,
//         textColor: Colors.white,
//         fontSize: 16);
//     debugPrint('Native Token:"$token"');
//
//     _instance._nativeToken = token;
//     _instance.notifyListeners();
//   }
//
//   ///  *********************************************
//   ///     BACKGROUND TASKS TEST
//   ///  *********************************************
//
//   static Future<void> executeLongTaskInBackground() async {
//     print("starting long task");
//     await Future.delayed(const Duration(seconds: 4));
//     final url = Uri.parse("http://google.com");
//     // final re = await http.get(url);
//     // print(re.body);
//     print("long task done");
//   }
//
//   ///  *********************************************
//   ///     REQUEST NOTIFICATION PERMISSIONS
//   ///  *********************************************
//
//   static Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     BuildContext context = LokalApp.navigatorKey.currentContext!;
//     await showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text('Get Notified!',
//                 style: Theme.of(context).textTheme.titleLarge),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Image.asset(
//                         'assets/animated-bell.gif',
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                     'Allow Lokal to send you Notifications!'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Deny',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.red),
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     userAuthorized = true;
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Allow',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.deepPurple),
//                   )),
//             ],
//           );
//         });
//     return userAuthorized &&
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }
//
//   ///  *********************************************
//   ///     LOCAL NOTIFICATION CREATION METHODS
//   ///  *********************************************
//
//   static Future<void> createNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//
//     if (!isAllowed) {
//       isAllowed = await displayNotificationRationale();
//     }
//
//     if (!isAllowed) return;
//
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: -1,
//           // -1 is replaced by a random number
//           channelKey: 'alerts',
//           title: 'Huston! The eagle has landed!',
//           body:
//           "A small step for a man, but a giant leap to Flutter's community!",
//           bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//           largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//           notificationLayout: NotificationLayout.BigPicture,
//           payload: {'notificationId': '1234567890'}),
//       actionButtons: [
//         NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//         NotificationActionButton(
//             key: 'REPLY',
//             label: 'Reply Message',
//             requireInputText: true,
//             actionType: ActionType.SilentAction),
//         NotificationActionButton(
//             key: 'DISMISS',
//             label: 'Dismiss',
//             actionType: ActionType.DismissAction,
//             isDangerousOption: true)
//       ],
//     );
//   }
//
//   static Future<void> resetBadge() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }
//
//   static Future<void> deleteToken() async {
//     await AwesomeNotificationsFcm().deleteToken();
//     await Future.delayed(Duration(seconds: 5));
//     await requestFirebaseToken();
//   }
//
//   ///  *********************************************
//   ///     REMOTE TOKEN REQUESTS
//   ///  *********************************************
//
//   static Future<String> requestFirebaseToken() async {
//     if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
//       try {
//         return await AwesomeNotificationsFcm().requestFirebaseAppToken();
//       } catch (exception) {
//         debugPrint('$exception');
//       }
//     } else {
//       debugPrint('Firebase is not available on this project');
//     }
//     return '';
//   }
//
//   static Future<void> saveFCMForUser(String fcmToken) async {
//     await ApiRepository.saveNotificationToken(
//         ApiRequestBody.getNotificationAddUserDetailsRequest(fcmToken, FCM));
//   }
// }
