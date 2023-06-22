import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LokalEvents {
  static void logEvent(String eventName, Map<String, dynamic> props) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: props,
    );
  }
}