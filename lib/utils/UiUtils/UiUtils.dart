import 'package:feedback/feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class UiUtils {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> shareOnWhatsApp(String url, String message) async {
    try {
      await FlutterShare.share(
        title: 'Lokal Jobs Available',
        text: message,
        linkUrl: url,
        chooserTitle: 'Share with:',
      );
    } catch (e) {
      print('Error sharing on WhatsApp: $e');
      // Handle any errors here
    }
  }

  static bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool isPhoneNoValid(String value) {
    final indianPhoneNumberRegex = RegExp(r'^[6-9][0-9]{9}$');

    // Check if the value matches the Indian mobile number pattern
    return indianPhoneNumberRegex.hasMatch(value);
  }

  static bool isNameValid(String name) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  }

  static void showFeedbackPanel(BuildContext context) {
    if (kDebugMode) {
      BetterFeedback.of(context).show((UserFeedback feedback) {
        print(feedback);
      });
    }
  }

  static String capitalizeFirstLetter(String str) {
    if (str.isEmpty) return str;
    List<String> words = str.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return capitalizedWords.join(' ');
  }
}
