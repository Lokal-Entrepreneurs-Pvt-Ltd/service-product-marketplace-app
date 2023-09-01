import 'package:flutter/material.dart';
//import 'package:flutter_switch/flutter_switch.dart';

class UikSwitch extends StatefulWidget {
  final Color? activebackgroundColor;
  final Color? activetopColor;
  final Color? inactivebackgroundColor;
  final Color? inactivetopColor;

  const UikSwitch({
    Key? key,
    this.activetopColor = Colors.yellow,
    this.activebackgroundColor = Colors.yellowAccent,
    this.inactivebackgroundColor = Colors.yellowAccent,
    this.inactivetopColor = Colors.white,
    //required this.isSwitched,
  }) : super(key: key);

  @override
  State<UikSwitch> createState() => _UikSwitchState(
        activetopColor ,
        activebackgroundColor,
        inactivebackgroundColor,
        inactivetopColor,
      );
}

class _UikSwitchState extends State<UikSwitch> {
  final Color? activebackgroundColor;
  final Color? activetopColor;
  final Color? inactivebackgroundColor;
  final Color? inactivetopColor;
  bool isSwitched = true;

  _UikSwitchState(this.activetopColor, this.activebackgroundColor,
      this.inactivetopColor, this.inactivebackgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Switch(
        splashRadius: 0,
        activeColor: activetopColor,
        activeTrackColor: activebackgroundColor,
        inactiveThumbColor: inactivebackgroundColor,
        inactiveTrackColor: inactivetopColor,
        value: isSwitched,
        onChanged: (value) => setState(() => isSwitched = value),
      ),
    );
  }
}
