import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:lokal/utils/Logs/event.dart';

class EventHandler {
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // static events(
  //     {required String name, Map<String, dynamic>? parameters}) async {
  //   await analytics.logEvent(name: name, parameters: parameters);
  // }
  static events({required Event event}) async {
    await FirebaseAnalytics.instance
        .logEvent(name: event.name, parameters: event.parameters);
  }
}
