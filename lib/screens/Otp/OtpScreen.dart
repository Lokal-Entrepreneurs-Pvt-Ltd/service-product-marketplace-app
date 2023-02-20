import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/constants/colors.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'dart:async';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import '../../widgets/UikButton/UikButton.dart';


class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({
    super.key,
    this.mobileNumber = "",
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int Seconds = 20;
  String digitSeconds = "20";
  Timer? timer;
  bool started = true;
  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 34,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ENTER_OTP,
                  style: TextStyle(
                    fontSize: DIMEN_32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "We sent it to ${UserDataHandler.getUserPhone()}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#9E9E9E"),
                  ),
                ),
              ],
            ),

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
            const SizedBox(
              height: 16,
            ),
            // Center(
            //   child: Pinput(
            //     length: 6,
            //     defaultPinTheme: PinTheme(
            //       height: 64,
            //       width: 48,
            //       decoration: BoxDecoration(
            //           borderRadius: const BorderRadius.all(Radius.circular(8)),
            //           color: HexColor("#F5F5F5")),
            //       textStyle: const TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 64,
                width: 327,
                child: UikButton(
                  text: CONTINUE,
                  widthSize: 327,
                  backgroundColor: const Color(0xffFEE440),
                  onClick: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Center(
              child: Text(
                "New code 00:$digitSeconds",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor(HEX_GRAY)),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (Seconds > 0) {
        int localSeconds = Seconds - 1;
        setState(() {
          Seconds = localSeconds;
          digitSeconds = (Seconds >= 10) ? "$Seconds" : "0$Seconds";
        });
      }
    });
  }
}
