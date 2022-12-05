import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';
// import "UikAvatar.dart";

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        UikAvatar(
          shape: UikAvatarShape.circle,
          size: UikSize.SMALL,
          backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
        ),
        SizedBox(
          width: 15,
        ),
        UikAvatar(
          shape: UikAvatarShape.circle,
          size: UikSize.MEDIUM,
          backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
        ),
        SizedBox(
          width: 15,
        ),
        UikAvatar(
          shape: UikAvatarShape.circle,
          size: UikSize.LARGE,
          backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
        ),
      ],
    ));
  }
}
