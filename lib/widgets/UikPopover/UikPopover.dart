// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/UikButton/UikButton.dart';
import 'package:popover/popover.dart';

class Popover extends StatelessWidget {
  final String headlineText;
  final bool desc;
  final String? descText;
  final List<List<dynamic>>? buttons;
  final bool textField;
  final String? textFieldText;
  final bool imageBool;
  final double? imgWidth, imgHeight;
  final String? inputImg;
  final double? popoverWidth;
  final double? popoverHeight;

  const Popover({
    Key? key,
    required this.headlineText,
    this.popoverWidth = 310,
    this.popoverHeight = 600,
    required this.desc,
    this.descText,
    this.buttons,
    required this.textField,
    this.textFieldText,
    required this.imageBool,
    this.imgHeight = 180,
    this.imgWidth = 279,
    this.inputImg,
  }) : super(key: key);

  void UikPopover(BuildContext context) {
    showPopover(
      context: context,
      bodyBuilder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            //FOR IMAGE
            if (imageBool == true) ...[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: 279,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(inputImg!),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              )
            ],

            //FOR HEADLINE AND DESC
            Container(
              width: 310,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Column(children: [
                  if (desc == true) ...[
                    Container(
                        width: 279,
                        height: 70,
                        child: Column(
                          children: [
                            Container(
                                child: Text(
                              headlineText,
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )),
                            Container(
                                child: Text(
                              descText!,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                          ],
                        ))
                  ] else ...[
                    Container(
                      width: 279,
                      height: 55,
                      child: Center(
                        child: Text(
                          headlineText,
                          style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ]
                ]),
              ),
            ),

            // FOR TEXTFIELD
            if (textField == true) ...[
              Container(
                width: 279,
                height: 64,
                // color: const Color(0xfff5f5f5),
                decoration: const BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: textFieldText,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              )
            ],

            //NUMBER OF BUTTONS
            for (var i = 0; i < buttons!.length; i++)
              Container(
                width: 279,
                height: 64,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(buttons![i].last),
                ),
                child: Center(child: Text(buttons![i].first)),
              )
          ],
        );
      },
      width: popoverWidth,
      arrowDxOffset: 10,
      constraints: BoxConstraints(maxHeight: popoverHeight!),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
