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

  static bool isGSTValid(String gst) {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(gst);
  }

  static bool isIFSCValid(String ifsc) {
    return RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc);
  }

  static bool isNumberValid(String number) {
    return RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(number);
  }

  static bool isPINCodeValid(String pinCode) {
    return RegExp(r'^[1-9][0-9]{5}$').hasMatch(pinCode);
  }

  static bool isDateTimeValid(String dateTime) {
    // Regular expression to match the format YYYY-MM-DD HH:MM
    final dateTimeRegExp = RegExp(
        r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01]) ([01][0-9]|2[0-3]):([0-5][0-9])$');
    return dateTimeRegExp.hasMatch(dateTime);
  }

  static bool isPhoneNoValid(String value) {
    final indianPhoneNumberRegex = RegExp(r'^[6-9][0-9]{9}$');

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
