import "package:flutter/material.dart";

class RadioButton extends StatefulWidget {
  final state;
  final borderRadius;
  const RadioButton({super.key, this.state, this.borderRadius = 180});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int check = 0;

  //get transparent => this.transparent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: 35,
          height: 35,
          // color: Colors.grey,
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: (check == 1)
                ? ((widget.state == "enabled")
                    ? Colors.yellow.withOpacity(0.4)
                    : Colors.yellow)
                : (Colors.grey[200]),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: (check == 1)
              ? Icon(
                  Icons.check_outlined,
                  color: (widget.state == "enabled")
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black,
                )
              : null,
        ),
        onTap: () => {
          //   print(transparent),
          setState(() {
            if (check == 0) {
              check = 1;
            } else {
              check = 0;
            }
          }),
        },
      ),
    );
  }
}
