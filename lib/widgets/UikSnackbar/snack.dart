import 'package:flutter/material.dart';
// import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';
import '../UikiIcon/uikIcon.dart';
import "./snackbar.dart";

class Snack extends StatelessWidget {
  final obj = const SnackBarPage(
    title: "Snackbar",
    //description: "yuvraj",
    //action: "Action",
    //iconVal: Icons.refresh_sharp,
    leftElement: UikIcon(
      valIcon: Icons.refresh,
      iconColor: Colors.white,
    ),
    // leftElement: UikAvatar(
    //   shape: UikAvatarShape.circle,
    //   size: UikSize.SMALL,
    //   backgroundImage: NetworkImage(
    //       "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
    // ),
    backgroundColor: Colors.black,
    // Trigger: UikButton(
    // backgroundColor: Colors.black,
    // textColor: Colors.yellow,
    //   ),
    //secondIcon: Icons.notifications_none_rounded,
  );
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  Snack({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        body: Container(
          child: Row(children: [
            ElevatedButton(
              onPressed: () {
                _messangerKey.currentState!.showSnackBar(obj.snackWidget());
              },
              child: const Text('Show My'),
            )
          ]),
        ),
      ),
    );
  }
}
