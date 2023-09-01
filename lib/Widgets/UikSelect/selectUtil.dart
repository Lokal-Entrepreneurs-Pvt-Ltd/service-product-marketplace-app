import 'package:flutter/material.dart';
// import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';
import 'package:lokal/Widgets/UikSelect/select.dart';

import '../../widgets/UikAvatar/uikAvatar.dart';

class SelectUtil extends StatelessWidget {
  const SelectUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MySelect(
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
