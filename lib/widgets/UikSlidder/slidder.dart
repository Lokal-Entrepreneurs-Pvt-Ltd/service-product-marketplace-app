
import "package:flutter/material.dart";
import 'package:lokal/widgets/UikSlidder/duoPolygon.dart';
import "./slidderUtil.dart";
//import 'package:flutter_xlider/flutter_xlider.dart';

class Slidder extends StatefulWidget {
  final isRange;
  final trackWidth;
  final minimum;
  final maximum;
  final isRounded;
  //final RangeValues initialValues;
  const Slidder({super.key, 
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
  RangeValues initialValues = const RangeValues(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2,
          thumbShape: (widget.isRounded != null)
              ? const RoundSliderThumbShape()
              : const PolygonSliderThumb(thumbRadius: 4),
          rangeThumbShape: (widget.isRounded != null)
              ? const RoundRangeSliderThumbShape()
              : const DuoPolygonSliderThumb(
                  thumbRadius: 4,
                ),
        ),
        child: (widget.isRange == null)
            ? SizedBox(
                width: widget.trackWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '$initialValue',
                          style: const TextStyle(
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
                      divisions: 10,
                      activeColor: const Color(0xFFFEE440),
                      inactiveColor: const Color(0xFFEEEEEE),
                      label: 'Set volume value',
                      onChanged: (value) {
                        setState(() {
                          initialValue = value;
                        });
                      },
                    ),
                  ],
                ),
              )
            : SizedBox(
                width: widget.trackWidth,
                child: Column(
                  children: [
                    Row(
                      //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            '${double.parse((initialValues.start).toStringAsFixed(2))}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 15,
                          ),
                          child: Text(
                            '${double.parse((initialValues.end).toStringAsFixed(2))}',
                            style: const TextStyle(
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
                      activeColor: const Color(0xFFFEE440),
                      inactiveColor: const Color(0xFFEEEEEE),
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
