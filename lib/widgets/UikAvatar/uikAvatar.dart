import 'package:flutter/material.dart';

enum UikAvatarShape {
  circle,
  standard,
  square,
}

class UikSize {
  static const double SMALL = 20;
  static const double MEDIUM = 35;
  static const double LARGE = 45;
}

class UikAvatar extends StatelessWidget {
  const UikAvatar(
      {Key? key,
      this.child,
      this.backgroundColor,
      this.backgroundImage,
      this.foregroundColor,
      this.radius,
      this.minRadius,
      this.maxRadius,
      this.borderRadius,
      this.shape = UikAvatarShape.circle,
      this.size = UikSize.MEDIUM})
      : assert(radius == null || (minRadius == null && maxRadius == null)),
        super(key: key);

  final Widget? child;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final ImageProvider? backgroundImage;

  final double? radius;

  final double? minRadius;

  final double? maxRadius;

  final double size;

  final UikAvatarShape shape;

  final BorderRadius? borderRadius;

  double get _minDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return 1.5 * size;
    } else {
      return 2.0 * (radius ?? minRadius ?? 0);
    }
  }

  double get _maxDiameter {
    if (radius == null && minRadius == null && maxRadius == null) {
      return 1.5 * size;
    } else {
      return 2.0 * (radius ?? maxRadius ?? 0);
    }
  }

  BoxShape get _avatarShape {
    if (shape == UikAvatarShape.circle) {
      return BoxShape.circle;
    } else if (shape == UikAvatarShape.square) {
      return BoxShape.rectangle;
    } else if (shape == UikAvatarShape.standard) {
      return BoxShape.rectangle;
    } else {
      return BoxShape.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? backgroundColor = this.backgroundColor;
    final Color? foregroundColor = this.foregroundColor;

    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.primaryTextTheme.titleMedium?.copyWith(
      color: foregroundColor,
    );
    Color? effectiveBackgroundColor = backgroundColor;

    if (effectiveBackgroundColor == null && textStyle?.color != null) {
      switch (ThemeData.estimateBrightnessForColor(textStyle!.color!)) {
        case Brightness.dark:
          effectiveBackgroundColor = theme.primaryColorLight;
          break;
        case Brightness.light:
          effectiveBackgroundColor = theme.primaryColorDark;
          break;
      }
    } else if (foregroundColor == null && textStyle != null) {
      switch (ThemeData.estimateBrightnessForColor(backgroundColor!)) {
        case Brightness.dark:
          textStyle = textStyle.copyWith(color: theme.primaryColorLight);
          break;
        case Brightness.light:
          textStyle = textStyle.copyWith(color: theme.primaryColorDark);
          break;
      }
    }
    final double minDiameter = _minDiameter;
    final double maxDiameter = _maxDiameter;
    return AnimatedContainer(
      constraints: BoxConstraints(
        minHeight: minDiameter,
        minWidth: minDiameter,
        maxWidth: maxDiameter,
        maxHeight: maxDiameter,
      ),
      duration: kThemeChangeDuration,
      decoration: BoxDecoration(
        color: Colors.white,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
              )
            : null,
        shape: _avatarShape,
        borderRadius: shape == UikAvatarShape.standard && borderRadius == null
            ? BorderRadius.circular(10)
            : borderRadius,
      ),
      // child: child == null && textStyle != null
      //     ? null
      //     : Center(
      //         child: MediaQuery(
      //           data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      //           child: IconTheme(
      //             data: theme.iconTheme.copyWith(color: textStyle?.color),
      //             child: DefaultTextStyle(
      //               style: textStyle!,
      //               child: child!,
      //             ),
      //           ),
      //         ),
      //       ),
    );
  }
}
