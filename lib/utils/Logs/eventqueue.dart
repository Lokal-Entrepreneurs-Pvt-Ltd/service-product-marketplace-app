import 'dart:collection';
import 'package:lokal/utils/logdataformat.dart';
import 'package:lokal/utils/logfeature.dart';

// class EventQueue with WidgetsBindingObserver{
//   static EventQueue? _instance;

//   EventQueue._(){
//      WidgetsBinding.instance.addObserver(this);
//   }

//   factory EventQueue() {
//     _instance ??= EventQueue._();
//     return _instance!;
//   }

//   final Queue _queue = Queue<Event>();
//   Queue get queue => _queue;

//   void add(Event event) {
//     if (_queue.length > 10) {
//       Event oldestevent = _queue.removeFirst();
//       EventHandler.events(event: oldestevent);
//     }
//     _queue.add(event);
//   }

//    @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive) {
//       handleEventQueueBeforeClose();
//     }
//   }

//   void handleEventQueueBeforeClose() {
//     while (_queue.isNotEmpty) {
//       Event remainingEvent = _queue.removeFirst();
//       EventHandler.events(event: remainingEvent);
//     }
//   }
// }

class EventQueue {
  static EventQueue? _instance;

  EventQueue._();

  factory EventQueue() {
    _instance ??= EventQueue._();
    return _instance!;
  }

  final Queue _queue = Queue<Event>();
  Queue get queue => _queue;

  void add(Event event) {
    if (_queue.length > 10) {
      while (_queue.isNotEmpty) {
        Event oldestevent = _queue.removeFirst();
        EventHandler.events(event: oldestevent);
      }
    }
    _queue.add(event);
  }
}
