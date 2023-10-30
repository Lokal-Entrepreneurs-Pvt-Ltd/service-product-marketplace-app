import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final BlendMode? blendMode;

  const GradientWidget({
    Key? key,
    required this.child,
    this.colors,
    this.blendMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: blendMode ?? BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
            colors: colors ??
                [
                  Colors.redAccent,
                  Colors.blueAccent,
                ])
            .createShader(bounds);
      },
      child: child,
    );
  }
}