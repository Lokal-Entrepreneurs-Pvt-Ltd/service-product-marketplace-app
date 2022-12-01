import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Otp extends StatefulWidget {
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  int start = 30;
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 44, 0, 0),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  Text(
                    "Help",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff212121)),
                  )
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "welcome!\nenter code from sms ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 4, 84, 26),
                // padding: EdgeInsets.fromLTRB(0, 0, 16, 0),

                child: Text("We sent it to +7 912 323-32-12",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xff9E9E9E),
                    ))),
            Form(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 118),
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 4),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 64,
                      width: 48,
                      // fillColor:Color(0xffF5F5F5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF5F5F5),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Color(0xffE0E0E0)),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffE0E0E0),
                              ),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 64,
                      width: 48,

                      // fillColor:Color(0xffF5F5F5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffE0E0E0)),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 64,
                      width: 48,

                      // fillColor:Color(0xffF5F5F5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffE0E0E0)),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 64,
                      width: 48,

                      // fillColor:Color(0xffF5F5F5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffE0E0E0)),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 64,
                      width: 48,

                      // fillColor:Color(0xffF5F5F5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffE0E0E0)),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 324),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "New Code ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color(0xff9E9E9E),
                  ),
                ),
                TextSpan(
                  text: "0:$start",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color(0xff9E9E9E),
                  ),
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
