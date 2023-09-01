import "package:flutter/material.dart";

class DuoPolygonSliderThumb extends RangeSliderThumbShape {
  final double thumbRadius;

  const DuoPolygonSliderThumb({
    required this.thumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      bool? isDiscrete,
      bool? isEnabled,
      bool? isOnTop,
      TextDirection? textDirection,
      required SliderThemeData sliderTheme,
      Thumb? thumb,
      bool? isPressed}) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: 32,
        height: 16,
      ),
      Radius.circular(thumbRadius),
    );

    final innerPathColor = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rRect, innerPathColor);
  }
}
