import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class ToolTip extends StatefulWidget {
  final List<String> ll;
  final child;
  final childwidth;
  final childheight;
  final direction;
  final bulletPoint;
  final NoBackground;

  const ToolTip({super.key, 
    required this.ll,
    this.direction = AxisDirection.down,
    this.child,
    this.bulletPoint = false,
    this.NoBackground = false,
    required this.childwidth,
    required this.childheight,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String callForLoop(List<String> ll) {
  String toReturn = "";
  for (int i = 0; i < ll.length - 1; i++) {
    String s = ll[i];
    toReturn = "$toReturn$s\n";
  }
  toReturn = toReturn + ll[ll.length - 1];

  return toReturn;
}

class _MyHomePageState extends State<ToolTip> {
  var Cheight = 60.0;
  var textColor;

  @override
  Widget build(BuildContext context) {
    String toPrint = callForLoop(widget.ll);
    Cheight += (10 * (widget.ll.length));
    var Elevation = 4.0;
    if (widget.NoBackground == true) {
      textColor = Colors.white;
      Elevation = 0.0;
    }
    if (widget.NoBackground == false) textColor = Colors.yellow;
    return Scaffold(
      body: JustTheTooltip(
        tailLength: 7,
        backgroundColor: textColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        tailBaseWidth: 12,
        preferredDirection: widget.direction,
        elevation: Elevation,
        content: Container(
          width: 84,
          height: Cheight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: textColor, width: 1.0),
          ),
          child: Column(
            children: [
              if (widget.bulletPoint) ...[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ToolTip",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.NoBackground == false
                          ? Colors.black
                          : const Color(0xFF9E9E9E),
                    ),
                  ),
                ),
                for (int i = 0; i < widget.ll.length; i++) ...[
                  Row(
                    children: [
                      const SizedBox(
                        width: 10.8,
                      ),
                      Container(
                        height: 10.4,
                        width: 10.4,
                        decoration: BoxDecoration(
                          color: widget.NoBackground == false
                              ? Colors.black
                              : const Color(0xFF9E9E9E),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 10.8,
                      ),
                      SizedBox(
                        width: 42,
                        height: 15,
                        child: Text(
                          widget.ll[i],
                          style: TextStyle(
                            color: widget.NoBackground == false
                                ? Colors.black
                                : const Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ],
              if (widget.bulletPoint == false) ...[
                for (int i = 0; i < widget.ll.length; i++) ...[
                  Container(
                    child: Text(
                      widget.ll[i],
                      style: TextStyle(
                        color: widget.NoBackground == false
                            ? Colors.black
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ],
            ],
          ),
        ),
        child: SizedBox(
          width: widget.childwidth,
          height: widget.childheight,
          child: widget.child,
        ),
      ),
    );
    // );
  }
}
