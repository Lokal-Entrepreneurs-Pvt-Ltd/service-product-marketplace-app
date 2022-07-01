import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class UikIcon extends StatelessWidget {
  //const UikIcon({Key? key}) : super(key: key);
  final valIcon;
  final iconColor;
  final borderRadius;
  final Color borderColor;
  final wid;
  final rad;
  const UikIcon(
      {this.rad,
      this.valIcon,
      this.iconColor,
      this.wid,
      this.borderRadius,
      this.borderColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: (rad != null) ? BorderRadius.circular(rad) : null,
        border: (wid != null)
            ? Border.all(
                color: borderColor,
                width: wid,
              )
            : null,
      ),
      child: Icon(
        valIcon,
        color: iconColor,
      ),
    );
  }
}
