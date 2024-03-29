import "package:flutter/material.dart";
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';

import './chips.dart';

class ChipUtil extends StatelessWidget {
  const ChipUtil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Chips(
      text: "mukul",
      backgroundColor: Colors.black,
      textColor: Colors.white,
      leftElement: UikAvatar(
        shape: UikAvatarShape.circle,
        size: UikSize.SMALL,
        backgroundImage: NetworkImage(
            "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
      ),
      rightElement: Icon(
        Icons.close,
        color: Colors.white,
      ),
      //avatar: "aaa",
    );
  }
}
