import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UikDivider extends StatelessWidget {
  final corner;
  final dividerSize;
  final widthSize;
  final dividerColor;
  const UikDivider({super.key, 
    this.corner,
    this.dividerSize = "Small",
    this.widthSize = 343,
    this.dividerColor = const Color(0xFF9FA8DA),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dividerSize == "Large") ...[
          Container(
            width: widthSize,
            height: 3,
            decoration: BoxDecoration(
                color: dividerColor,
                border: Border.all(
                  color: dividerColor,
                ),
                borderRadius: (corner == "Round")
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(0)),
          ),
        ] else if (dividerSize == "Medium") ...[
          Container(
            width: widthSize,
            height: 2,
            decoration: BoxDecoration(
                color: dividerColor,
                border: Border.all(
                  color: dividerColor,
                ),
                borderRadius: (corner == "Round")
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(0)),
          ),
        ] else ...[
          Container(
            width: widthSize,
            height: 1,
            decoration: BoxDecoration(
                color: dividerColor,
                border: Border.all(
                  color: dividerColor,
                ),
                borderRadius: (corner == "Round")
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(0)),
          ),
        ]
      ],
    );
  }
}
