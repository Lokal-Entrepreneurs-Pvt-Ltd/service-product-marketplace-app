import 'package:lokal/utils/Logs/event_handler.dart';
import 'package:lokal/utils/Logs/eventsdk.dart';

class Event {
  String name;
  Map<String, dynamic> parameters;

  Event._(this.name, this.parameters);

  factory Event.build(
      {required String name,
      String? apiEndPoint,
      String? action,
      String? route,
      String? apiError,
      String? actionError,
      String? routeError}) {
    final params = <String, dynamic>{};
    _addIfNotNull(params, 'sessionId', EventSDK.sessionId);
    _addIfNotNull(params, 'userId', EventSDK.userId);
    _addIfNotNull(params, 'apiEndPoint', apiEndPoint);
    _addIfNotNull(params, 'action', action);
    _addIfNotNull(params, 'route', route);
    _addIfNotNull(
        params,
        'apiError',
        (apiEndPoint != null)
            ? (apiError != null)
                ? apiError
                : "No Error"
            : null);
    _addIfNotNull(
        params,
        'actionError',
        (action != null)
            ? (actionError != null)
                ? action
                : "No Error"
            : null);
    _addIfNotNull(
        params,
        'routeError',
        (route != null)
            ? (routeError != null)
                ? routeError
                : "No Error"
            : null);
    return Event._(name, params);
  }

  static void _addIfNotNull(
      Map<String, dynamic> map, String key, dynamic value) {
    if (value != null) {
      map[key] = value;
    }
  }

  void updateParameters(
      {String? pageName,
      String? action,
      String? route,
      String? apiError,
      String? actionError,
      String? routeError}) {
    _addIfNotNull(parameters, 'pageName', pageName);
    _addIfNotNull(parameters, 'action', action);
    _addIfNotNull(parameters, 'route', route);
    _addIfNotNull(parameters, 'apiError', apiError);
    _addIfNotNull(parameters, 'actionError', actionError);
    _addIfNotNull(parameters, 'routeError', routeError);
  }

  void fire() async {
    try {
      EventHandler.events(event: this);
    } catch (e) {
      print('Error firing event $name: $e');
    }
  }
}
