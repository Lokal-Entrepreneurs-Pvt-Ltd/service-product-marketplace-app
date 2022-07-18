import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextArea extends StatelessWidget {
  final label;
  final widthVal;
  final heightVal;
  final corner;
  final border;
  final background;
  final bgcolor;
  final hinttext;

  const TextArea({
    super.key,
    this.label,
    this.heightVal,
    this.widthVal,
    this.corner,
    this.border,
    this.background,
    this.bgcolor,
    this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints(
      //     maxHeight: 317, maxWidth: 205, minHeight: 163, minWidth: 148),
      // margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CONTAINER FOR LABEL
          if (label == true) ...[
            Container(
                width: 37,
                height: 16,
                child: Text(
                  'Label',
                  style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff212121)),
                )),
          ],

          //CONTAINER FOR TEXT AREA
          Container(
            // margin: EdgeInsets.only(top: 10),
            height: heightVal,
            width: widthVal,
            child: TextField(
              expands: true,
              maxLines: null,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 5, 15),
                  hintText: hinttext,
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff9e9e9e)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: (corner == 'rounded')
                        ? (const BorderRadius.all(Radius.circular(15)))
                        : (const BorderRadius.all(Radius.circular(8))),
                    borderSide: (border == true)
                        ? (const BorderSide(
                            color: Color(0xff9E9E9E), width: 1.0))
                        : (BorderSide.none),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: (corner == 'rounded')
                        ? (const BorderRadius.all(Radius.circular(15)))
                        : (const BorderRadius.all(Radius.circular(8))),
                    borderSide: (border == true)
                        ? (const BorderSide(
                            color: Color(0xff9E9E9E), width: 1.0))
                        : (BorderSide.none),
                  ),
                  filled: (background == true) ? true : false,
                  fillColor: bgcolor,
                  hoverColor: bgcolor),
            ),
          )
        ],
      ),
    );
  }
}
