



// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'firebase/firebase_options.dart';


 class AppInitializer {

    init() async {
      await _initFirebase();
     // _initNotifications();
     WidgetsFlutterBinding.ensureInitialized();
   }

    _initFirebase() async {
      WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
   }
   // _initNotifications(){
   //   AwesomeNotificationsFcm().initialize(
   //       onFcmSilentDataHandle: NotificationController.mySilentDataHandle,
   //       onFcmTokenHandle: NotificationController.myFcmTokenHandle,
   //       onNativeTokenHandle: NotificationController.myNativeTokenHandle);
   //   AwesomeNotifications().initialize(
   //     // set the icon to null if you want to use the default app icon
   //       '',
   //       [
   //         NotificationChannel(
   //             channelGroupKey: 'basic_channel_group',
   //             channelKey: 'basic_channel',
   //             channelName: 'Basic notifications',
   //             channelDescription: 'Notification channel for basic tests',
   //             defaultColor: Color(0xFF9D50DD),
   //             ledColor: Colors.white)
   //       ],
   //       // Channel groups are only visual and are not required
   //       channelGroups: [
   //         NotificationChannelGroup(
   //             channelGroupKey: 'basic_channel_group',
   //             channelGroupName: 'Basic group')
   //       ],
   //       debug: true);
   //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
   //     if (!isAllowed) {
   //       AwesomeNotifications().requestPermissionToSendNotifications();
   //     }
   //   });
   //   checkNotificationPermission() {
   //     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
   //       if (!isAllowed) {
   //         AwesomeNotifications().requestPermissionToSendNotifications();
   //       }
   //     });
   //   }
   // }

   launchHomescreen(){

   }



   static Future<void> initDynamicLinks(BuildContext context, FirebaseDynamicLinks dynamicLinks) async {

      dynamicLinks.onLink.listen((dynamicLinkData) {
        final Uri uri = dynamicLinkData.link;
        final queryParameter = uri.queryParameters;


        if (queryParameter.isNotEmpty) {
          String? username = queryParameter["username"];
          String? password = queryParameter["password"];

          Navigator.pushNamed(context, dynamicLinkData.link.path, arguments: {
            "username": username,
            "password": password,
          });
        } else {
          Navigator.pushNamed(context, dynamicLinkData.link.path);
        }
      }).onError((error) {
        print(error);
      });
    }
 }

