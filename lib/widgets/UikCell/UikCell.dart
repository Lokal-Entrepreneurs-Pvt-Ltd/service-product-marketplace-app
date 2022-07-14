import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikSwitch/UikSwitch.dart';


class Cell extends StatelessWidget {
  final String titleText;
  final Widget? rightChild;
  final Widget? leftChild;
  final subtitleText;
  const Cell({
    required this.titleText,
    this.rightChild,
    this.leftChild,
    this.subtitleText,
  }) ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
          leading: Container(
            margin: (subtitleText != null)? EdgeInsets.only(top: 5): EdgeInsets.all(0),
            child: (leftChild != null)? leftChild :null,
          ),
          title: Text(titleText),
          subtitle:(subtitleText != null)? Text(subtitleText): Text(""),
          trailing: (rightChild != null)? rightChild :null,
        );
  }
}
