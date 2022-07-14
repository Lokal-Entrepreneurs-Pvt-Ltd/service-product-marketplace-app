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
  final isRounded;
  //final RangeValues initialValues;
  Slidder({
    this.isRange,
    this.isRounded,
    this.trackWidth = 343.0,
    this.minimum = 0.0,
    this.maximum = 100.0,
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
    return Container(
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2,
          thumbShape: (widget.isRounded != null)
              ? RoundSliderThumbShape()
              : PolygonSliderThumb(thumbRadius: 4),
          rangeThumbShape: (widget.isRounded != null)
              ? RoundRangeSliderThumbShape()
              : DuoPolygonSliderThumb(
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
                      //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            '${double.parse((initialValues.start).toStringAsFixed(2))}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: Text(
                            '${double.parse((initialValues.end).toStringAsFixed(2))}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
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
