import "package:flutter/material.dart";

class RadioButton extends StatefulWidget {
  final transparent;
  RadioButton({this.transparent});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int check = 0;

  //get transparent => this.transparent;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: GestureDetector(
        child: Container(
          width: 35,
          height: 35,
          // color: Colors.grey,
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: (check == 1)
                ? ((widget.transparent == true)
                    ? Colors.yellow.withOpacity(0.4)
                    : Colors.yellow)
                : (Colors.grey[200]),
            borderRadius: BorderRadius.circular(180),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: (check == 1)
              ? Icon(
                  Icons.check_outlined,
                  color: (widget.transparent == true)
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
    ));
  }
}
