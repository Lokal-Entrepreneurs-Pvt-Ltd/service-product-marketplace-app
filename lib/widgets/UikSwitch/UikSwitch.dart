import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_switch/flutter_switch.dart';

class toggleSwitch extends StatefulWidget {
  final Color activebackgroundColor;
  final Color activetopColor;
  final Color inactivebackgroundColor;
  final Color inactivetopColor;

  const toggleSwitch({
    Key? key,
    required this.activetopColor,
    required this.activebackgroundColor,
    required this.inactivebackgroundColor,
    required this.inactivetopColor,
    //required this.isSwitched,
  }) : super(key: key);

  @override
  State<toggleSwitch> createState() => _toggleSwitchState(
        this.activetopColor,
        this.activebackgroundColor,
        this.inactivebackgroundColor,
        this.inactivetopColor,
      );
}

class _toggleSwitchState extends State<toggleSwitch> {
  final Color activebackgroundColor;
  final Color activetopColor;
  final Color inactivebackgroundColor;
  final Color inactivetopColor;
  bool isSwitched = true;

  _toggleSwitchState(this.activetopColor, this.activebackgroundColor,
      this.inactivetopColor, this.inactivebackgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Switch(
        activeColor: activetopColor,
        activeTrackColor: activebackgroundColor,
        inactiveThumbColor: inactivetopColor,
        inactiveTrackColor: inactivebackgroundColor,
        value: isSwitched,
        onChanged: (value) => setState(() => isSwitched = value),
      ),
    );
  }
}
