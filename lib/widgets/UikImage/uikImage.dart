import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

enum UikShape {
  circle,
  rectangle,
}

class UikSize {
  static const double SMALL = 20;
  static const double MEDIUM = 35;
  static const double LARGE = 45;
}

class UikImage extends StatelessWidget {
  //const UikImage({Key? key}) : super(key: key);
  final valImage;
  final Color borderColor;
  final iFit;
  final wid;
  final iHeight;
  final iOpacity;
  final iWidth;
  final rad;
  final UikShape? shape;
  final double? size;
  final BorderRadius? borderRadius;

  const UikImage(
      {this.iHeight,
      this.iOpacity,
      this.iFit,
      this.rad,
      this.iWidth,
      this.wid,
      this.borderRadius,
      this.size,
      this.valImage,
      this.shape,
      this.borderColor = Colors.black});
  BoxShape get _uikShape {
    if (shape == UikShape.circle) {
      return BoxShape.circle;
    } else if (shape == UikShape.rectangle) {
      return BoxShape.rectangle;
    } else {
      return BoxShape.rectangle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: valImage,
        height: iHeight,
        width: iWidth,
        fit:iFit, 
        opacity: iOpacity,

      ),
      decoration: BoxDecoration(
        borderRadius: (rad != null) ? BorderRadius.circular(rad) : null,
        border: (wid != null)
            ? Border.all(
                color: borderColor,
                width: wid,
              )
            : null,
      ),
    );
  }
}
