import "package:flutter/material.dart";
import 'package:login/widgets/UikIcon/uikIcon.dart';

import '../../widgets/UikNavbar/UikNavbar.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //for navBar
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: const MyAppBar(
                //transparent: true,
                size: "small",
                titletxt: "My orders",
                titletxtSize: 16,
                lefticon: Icons.arrow_back,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
