import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// void main() {
//   runApp(const Toast1());
// }

class MyStaticClass {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

// static class Toast1 extends StatelessWidget {
//   const Toast1({Key? key}) : super(key: key);

// // This widget is the
// // root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Center(
//       child: TextButton(
//         onPressed: () {
//           Fluttertoast.showToast(
//             msg: 'Hello',
//             backgroundColor: Colors.grey,
//           );
//         },
//         child: Container(
//           padding: const EdgeInsets.all(14),
//           color: Colors.green,
//           child: const Text(
//             'Show',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ));
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
// // ignore: library_private_types_in_public_api
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             Fluttertoast.showToast(
//               msg: 'Hello',
//               backgroundColor: Colors.grey,
//             );
//           },
//           child: Container(
//             padding: const EdgeInsets.all(14),
//             color: Colors.green,
//             child: const Text(
//               'Show',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
