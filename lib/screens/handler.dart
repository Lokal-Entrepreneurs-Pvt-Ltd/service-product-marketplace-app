
import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:lokal/utils/ActionUtils.dart';

import '../utils/deeplink_handler.dart';


abstract class Handler {
  static void logout(Message message) async {

  }

  static void executeAction(Message message) {
    print( message.payload);
    // if(message.payload)
    // ActionUtils.executeAction(message.uikAction);

  }

  static void openPage(Message message) {
    print( message.payload);
    DeeplinkHandler.openPage(message.getMountedContext()!,"");
  }
}
