import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:login/widgets/UikSwitch/UikSwitch.dart';

class Cell extends StatelessWidget {
  final String titleText;
  final Widget? rightChild;
  final Widget? leftChild;
  final subtitleText;
  final titlesize, titleWeight, titleColor;
  final subtitlesize, subtitleWeight, subtitleColor;
  const Cell(
      {required this.titleText,
      this.rightChild,
      this.leftChild,
      this.subtitleText,
      this.subtitlesize,
      this.subtitleWeight,
      this.subtitleColor,
      this.titlesize,
      this.titleWeight,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: (subtitleText != null)
            ? EdgeInsets.only(top: 5)
            : EdgeInsets.all(0),
        child: (leftChild != null) ? leftChild : null,
      ),
      title: Container(
        margin: (subtitleText == null)
            ? EdgeInsets.only(top: 13)
            : EdgeInsets.all(0),
        child: Text(
          titleText,
          style: GoogleFonts.poppins(
              fontSize: titlesize, fontWeight: titleWeight, color: titleColor),
        ),
      ),
      subtitle: (subtitleText != null)
          ? Text(
              subtitleText,
              style: GoogleFonts.poppins(
                  fontSize: titlesize,
                  fontWeight: titleWeight,
                  color: titleColor),
            )
          : Text(""),
      trailing: (rightChild != null) ? rightChild : null,
    );
  }
}
