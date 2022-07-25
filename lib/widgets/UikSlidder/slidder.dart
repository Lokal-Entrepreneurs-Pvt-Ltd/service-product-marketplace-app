import 'dart:math';

import "package:flutter/material.dart";
import 'package:login/widgets/UikSlidder/duoPolygon.dart';
import "./slidderUtil.dart";
//import 'package:flutter_xlider/flutter_xlider.dart';

class Slidder extends StatefulWidget {
  final isRange;
  final trackWidth;
  final minimum;
  final maximum;

  //final RangeValues initialValues;
  Slidder({
    this.isRange,
    this.trackWidth = 343,
    this.minimum = 0,
    this.maximum = 100,
  });
  //RangeValues initialValues = RangeValues(, );
  @override
  State<Slidder> createState() => _SlidderState();
}

class _SlidderState extends State<Slidder> {
  double initialValue = 0;
  RangeValues initialValues = RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2,
          thumbShape: PolygonSliderThumb(thumbRadius: 4),
          rangeThumbShape: DuoPolygonSliderThumb(
            thumbRadius: 4,
          ),
        ),
        child: (widget.isRange == null)
            ? Container(
                width: widget.trackWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${initialValue}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: initialValue,
                      min: widget.minimum,
                      max: widget.maximum,

                      // divisions: 10,
                      activeColor: Color(0xFFFEE440),
                      inactiveColor: Color(0xFFEEEEEE),
                      //label: 'Set volume value',
                      onChanged: (value) {
                        setState(() {
                          initialValue = value;
                        });
                      },
                    ),
                  ],
                ),
              )
            : Container(
                width: widget.trackWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${initialValues.start}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${initialValues.end}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      min: widget.minimum,
                      max: widget.maximum,
                      values: initialValues,
                      activeColor: Color(0xFFFEE440),
                      inactiveColor: Color(0xFFEEEEEE),
                      onChanged: (value) {
                        setState(() {
                          initialValues = value;
                          print(initialValues);
                        });
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
