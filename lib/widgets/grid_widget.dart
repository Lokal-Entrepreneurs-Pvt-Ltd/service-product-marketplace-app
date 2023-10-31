import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikImage/uikImage.dart';

class GridWidget extends StatelessWidget {
  const GridWidget(
      {Key? key,
      this.childAspectRatio,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.crossAxisCount,
      required this.imageSrcList,
      required this.scrollDirection,
      this.borderRadius})
      : super(key: key);
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final double? crossAxisCount;
  final double? borderRadius;
  final List<String> imageSrcList;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: childAspectRatio ?? 1,
      crossAxisSpacing: crossAxisSpacing ?? 0,
      mainAxisSpacing: mainAxisSpacing ?? 0,
      scrollDirection: scrollDirection,
      crossAxisCount: 3,
      children: List.generate(
          imageSrcList.length,
          (index) => UikImage(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                valImage: AssetImage(imageSrcList[index]),
              )),
    );
  }
}
