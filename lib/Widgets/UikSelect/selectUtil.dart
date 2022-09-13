import 'package:flutter/material.dart';
import 'package:login/Widgets/UikAvatar/UikAvatar.dart';
import 'package:login/Widgets/UikSelect/select.dart';

class SelectUtil extends StatelessWidget {
  const SelectUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MySelect(
      Corner: "Rounded",
      noIcon: true,
      Heading: true,
      Border: true,
      Disable: false,
      size: "Medium",
      avtar: UikAvatar(
        backgroundColor: Colors.white,
        radius: 10,
      ),
    );
  }
}
