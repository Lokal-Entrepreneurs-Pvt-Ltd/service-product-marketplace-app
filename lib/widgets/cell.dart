import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/app_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:login/widgets/toggleSwitch.dart';

class Cell extends StatelessWidget {
  //final class AppButton;
  final String titleText;
  final Widget? rightChild;
  final Widget? leftChild;
  final subtitleText;
  const Cell({
    Key? key,
    //this.AppButton,
    required this.titleText,
    this.rightChild,
    this.leftChild,
    this.subtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        // height: 0,
        // width: 0,
        //color: Colors.red,
        margin: (subtitleText != null)? EdgeInsets.only(top: 5): EdgeInsets.all(0),
        child: (leftChild != null)? leftChild :null,
      ),
      title: Text(titleText), //Text("Cell"),
      subtitle:(subtitleText != null)? Text(subtitleText): Text(""),
      trailing: (rightChild != null)? rightChild :null,
    );
  }
}


// AppButton(
//         backgroundColor: Colors.yellow,
//         borderColor: Colors.transparent,
//         widthSize: 79,
//         heightSize: 36,
//         text: "Button",
//         textColor: Colors.black,
//       ),
// Container(
//         child: Column(
//           children: [
//             if (type == 'button') ...[
//               Container(
//                 child: AppButton(
//                   backgroundColor: Colors.yellow,
//                   borderColor: Colors.transparent,
//                   widthSize: 79,
//                   heightSize: 36,
//                   text: "Button",
//                   textColor: Colors.black,
//                 ),
//               ),
//             ] else if (type == 'switch') ...[
//               Container(
//                 child: toggleSwitch(
//                   activetopColor: Color(0xffFEE440),
//                   activebackgroundColor: Color(0xffFFF8CF),
//                   inactivebackgroundColor: Color(0xffEEEEEE),
//                   inactivetopColor: Color(0xffF5F5F5),
//                 ),
//               )
//             ]
//           ],
//         ),
//       )