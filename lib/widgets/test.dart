// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:just_the_tooltip/just_the_tooltip.dart';

// class ToolTip extends StatefulWidget {
//   final List<String> ll;
//   final child;
//   final s;

//   final taillength;

//   const ToolTip(
//       {required this.ll,
//       this.s = AxisDirection.down,
//       this.child,
//       required this.taillength});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// String callForLoop(List<String> ll) {
//   String toReturn = "";
//   for (int i = 0; i < ll.length - 1; i++) {
//     String s = ll[i];
//     toReturn = toReturn + s + "\n";
//   }
//   toReturn = toReturn + ll[ll.length - 1];

//   return toReturn;
// }

// class _MyHomePageState extends State<ToolTip> {
//   @override
//   Widget build(BuildContext context) {
//     String toPrint = callForLoop(widget.ll);
//     return JustTheTooltip(
//       tailLength: widget.taillength,

//       elevation: 0,
//       backgroundColor: Colors.yellow,
//       shadow: null,
//       // tailLength: 0,
//       // tailBaseWidth: 0,
//       preferredDirection: widget.s,
//       barrierDismissible: false,
//       // margin: EdgeInsets.all(10),
//       // curve: Curves.easeInOut,
//       // ignore: prefer_const_constructors
//       child: Container(
//         //fit: FlexFit.loose,
//         width: 100,
//         height: 100,
//         color: Colors.red,
//         child: widget.child,
//       ),
//       content: Container(
//         padding: EdgeInsets.all(10.0),
//         width: 73,
//         height: 95,
//         decoration: BoxDecoration(
//           // color: backgroundColor,
//           borderRadius: BorderRadius.circular(7),
//           border: Border.all(color: Colors.yellow, width: 1.0),
//         ),
//         child: Text(toPrint),
//       ),
//     );
//     // );
//   }
// }
