import 'package:flutter/material.dart';
// import 'package:login/Widgets/UikAvatar/UikAvatar.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';

class UikTags extends StatelessWidget {
  const UikTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            print("Button is cliked");
          },
          child: Container(
            width: 102,
            height: 36,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.black,
            ),
            child: Row(
              children: [
                Container(
                  child: UikAvatar(
                    shape: UikAvatarShape.circle,
                    size: UikSize.SMALL,
                    backgroundColor: Colors.brown,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  child: Text("Brown", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
