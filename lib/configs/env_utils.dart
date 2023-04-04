

import '../utils/UiUtils/UiUtils.dart';
import 'environment.dart';
import 'environment_data_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokal/utils/storage/preference_util.dart';


class EnvUtils {

  static void setEnvironmentAndResetApp(BuildContext context,
      String environment, String localUrl) {
    switch (environment) {
      case Environment.PROD:
        {
          UiUtils.showToast("Prod Env Set,  Restart the app");
        }
        break;
      case Environment.LOCAL:
        {
          if (localUrl.isNotEmpty) {
            EnvironmentDataHandler.setLocalBaseUrl(localUrl);
            UiUtils.showToast(
                "Local Url set: " + localUrl + " Restart the app");
          }
          else
            UiUtils.showToast("invalid url");
        }
        break;
      default :
        {
          UiUtils.showToast("Dev Env Set,  Restart the app");
        }
    }
    EnvironmentDataHandler.setDefaultEnvironment(environment);
    Navigator.pop(context);
    SystemNavigator.pop();
  }
//
//   static void displayTextInputDialog(BuildContext context) async {
//     var tempLocalUrl=EnvironmentDataHandler.getLocalBaseUrl();
//   return showDialog(
//       context: context,
//       builder: (context) {
//         var _textFieldController = TextEditingController(text: EnvironmentDataHandler.getLocalBaseUrl());
//         return AlertDialog(
//           title: Text('Set Ngrok URL'),
//           content: TextField(
//             onChanged: (value) {
//               setState(() {
//                 tempLocalUrl = value;
//               });
//             },
//             controller: _textFieldController,
//             decoration: InputDecoration( hintText: "Enter the local url"),
//           ),
//           actions: <Widget>[
//             MaterialButton(
//               color: Colors.red,
//               textColor: Colors.white,
//               child: const Text('Clear Data and Kill App'),
//               onPressed: () {
//                 setState(() {
//                   UiUtils.showToast("Data Cleared, Restart the app");
//                   PreferenceUtils.clearStorage();
//                   SystemNavigator.pop();
//                 });
//               },
//             ),
//             MaterialButton(
//               color: Colors.red,
//               textColor: Colors.white,
//               child: const Text('Set Prod'),
//               onPressed: () {
//                 setState(() {
//                   setEnvironmentAndResetApp(context,Environment.PROD,"");
//                 });
//               },
//             ),
//             MaterialButton(
//               color: Colors.green,
//               textColor: Colors.white,
//               child: const Text('Set Dev'),
//               onPressed: () {
//                 setState(() {
//                   setEnvironmentAndResetApp(context, Environment.DEV,"");
//                 });
//               },
//             ),
//             MaterialButton(
//               color: Colors.blue,
//               textColor: Colors.white,
//               child: Text('Set Lokal'),
//               onPressed: () {
//                 setState(() {
//                   if(tempLocalUrl.isNotEmpty && tempLocalUrl.endsWith("ngrok.io"))
//                   {
//                     setEnvironmentAndResetApp(context,Environment.DEV,tempLocalUrl);
//                   }
//                   else
//                     UiUtils.showToast("Invalid url");
//                 });
//               },
//             ),
//           ],
//         );
//       });
// }
}