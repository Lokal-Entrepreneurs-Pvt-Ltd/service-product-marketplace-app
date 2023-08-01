import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/constants/colors.dart';
import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/screens/otp.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:async';
import '../../../constants/dimens.dart';
import '../../../constants/strings.dart';
import '../../../utils/network/http/http_screen_client.dart';
import '../../../widgets/UikButton/UikButton.dart';

class AddAgentOtp extends StatefulWidget {
  @override
  State<AddAgentOtp> createState() => _AddAgentOtpState();
}

class _AddAgentOtpState extends State<AddAgentOtp> {
  int Seconds = 20;
  String digitSeconds = "20";
  Timer? timer;
  bool started = true;

  String otpPinEntered = "";

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    var phoneNo = args['phoneNo'];
    var partnerId = args['partnerId'];

    print(args);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: DIMEN_34,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(DIMEN_16),
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
                  "We sent it to $phoneNo",
                  style: TextStyle(
                    fontSize: DIMEN_16,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#9E9E9E"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DIMEN_20),
            OTPTextField(
              length: 6,
              width: double.infinity,
              fieldWidth: DIMEN_40,
              style: const TextStyle(fontSize: DIMEN_18),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                otpPinEntered = pin;
              },
            ),
            const SizedBox(height: DIMEN_20),
            const SizedBox(
              height: DIMEN_16,
            ),
            Padding(
              padding: const EdgeInsets.all(DIMEN_16),
              child: SizedBox(
                height: DIMEN_64,
                width: DIMEN_327,
                child: UikButton(
                  text: CONTINUE,
                  widthSize: DIMEN_327,
                  backgroundColor: const Color(0xFFFEE440),
                  onClick: () async {
                    if (otpPinEntered.length == 6) {
                      final response = await ApiRepository.verifyAddFleetOtp(
                        ApiRequestBody.getVerifyAddFleetOtpRequest(
                            phoneNo, otpPinEntered, partnerId),
                      );
                      if (response.isSuccess!) {
                        if (response.data) {
                          HttpScreenClient.displayDialogBox(
                              ADD_AGENT_SUCESSFULL);
                        } else {
                          HttpScreenClient.displayDialogBox(ADD_AGENT_FAILED);
                        }
                      } else {
                        UiUtils.showToast(response.error![MESSAGE]);
                      }
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: DIMEN_18,
            ),
            Center(
              child: Text(
                "New code 00:$digitSeconds",
                style: TextStyle(
                  fontSize: DIMEN_16,
                  fontWeight: FontWeight.w500,
                  color: HexColor(HEX_GRAY),
                ),
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
