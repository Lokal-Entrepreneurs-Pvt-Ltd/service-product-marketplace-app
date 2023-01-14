import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/constants/colors.dart';
import 'package:lokal/screens/RegistrationTwoScreen/RegistrationTwoScreen.dart';
import 'package:pinput/pinput.dart';
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
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: DIMEN_32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "We sent it to +91-${widget.mobileNumber}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#9E9E9E"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  height: 64,
                  width: 48,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: HexColor("#F5F5F5")),
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 64,
                width: 327,
                child: UikButton(
                  text: "Continue",
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
