import 'package:flutter/material.dart';

import '../../widgets/UikAvatar/uikAvatar.dart';
// import 'package:lokal/Widgets/UikAvatar/UikAvatar.dart';

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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.black,
            ),
            child: Row(
              children: [
                Container(
                  child: const UikAvatar(
                    shape: UikAvatarShape.circle,
                    size: UikSize.SMALL,
                    backgroundColor: Colors.brown,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  child: const Text("Brown", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
