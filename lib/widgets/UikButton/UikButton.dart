import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum UikButtonType {
  primary,
  secondary,
  outline,
  ghost,
}

class UikButton extends StatelessWidget {
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final String text;
  final double widthSize;
  final double heightSize;
  final FontWeight textWeight;
  final double textSize;
  final Widget? rightElement;
  final Widget? leftElement;
  final VoidCallback? onClick;
  final UikButtonType type;
  final bool disabled;
  final bool stuck;

  UikButton({
    super.key,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.yellow,
    this.textWeight = FontWeight.normal,
    this.textSize = 14.0,
    this.textColor = Colors.black,
    this.text = "Button",
    this.widthSize = double.infinity,
    this.heightSize = 64.0,
    this.rightElement,
    this.leftElement,
    this.onClick,
    this.type = UikButtonType.primary,
    this.disabled = false,
    this.stuck = true,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: disabled ? null : onClick,
        child: Container(
          width: widthSize,
          height: heightSize,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: borderColor, width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLeadingIcon(),
              _buildText(),
              _buildTrailingIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return leftElement != null && !stuck
        ? Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: leftElement!,
    )
        : Container();
  }

  Widget _buildText() {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: textWeight,
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }

  Widget _buildTrailingIcon() {
    return rightElement != null && !stuck
        ? Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: rightElement!,
    )
        : Container();
  }
}
