import 'package:flutter/material.dart';

class UikIcon extends StatelessWidget {
  //const UikIcon({Key? key}) : super(key: key);
  final valIcon;
  final iconColor;
  final borderRadius;
  final Color borderColor;
  final wid;
  final rad;
  final iconSize;
  final backgroundColor;
  final padding;
  const UikIcon(
      {super.key, this.rad,
      this.valIcon,
      this.iconColor,
      this.wid,
      this.backgroundColor,
      this.padding,
      this.borderRadius,
      this.iconSize,
      this.borderColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
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
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
