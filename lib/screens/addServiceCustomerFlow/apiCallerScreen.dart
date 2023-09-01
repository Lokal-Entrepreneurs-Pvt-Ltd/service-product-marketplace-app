import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/screens/addServiceCustomerFlow/errorScreen.dart';
import 'package:lokal/screens/addServiceCustomerFlow/successScreen.dart';
import 'package:lottie/lottie.dart';

import '../../constants/strings.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';

class ApiCallerScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String email;
  final String age;
  final String state;
  final String district;
  final String block;
  final String pinCode;
  final String employment;

  const ApiCallerScreen({super.key, 
    required this.name,
    required this.phoneNumber,
    required this.age,
    required this.email,
    required this.state,
    required this.district,
    required this.block,
    required this.pinCode,
    required this.employment,
  });

  @override
  _ApiCallerScreenState createState() => _ApiCallerScreenState();
}

class _ApiCallerScreenState extends State<ApiCallerScreen> {
  @override
  void initState() {
    super.initState();
    _callApi();
  }

  void _callApi() async {
    try {
      final response = await ApiRepository.submitUserServiceCreateCustomerForm(
        ApiRequestBody.submitUserServiceCreateCustomerFormRequest(
          widget.name,
          widget.phoneNumber,
          widget.age,
          widget.email,
          widget.state,
          widget.district,
          widget.block,
          widget.pinCode,
          widget.employment
        ),
      );
      if (response.isSuccess!) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(
              animationAsset: SUCCESS_LOTTIE,
              message: ADD_SERVICE_CUSTOMER_SUCCESS,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ErrorScreen(
              animationAsset: ERROR_LOTTIE,
              message: ADD_SERVICE_CUSTOMER_FAIL,
            ),
          ),
        );
      }
    } catch (error) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ErrorScreen(
            animationAsset: ERROR_LOTTIE,
            message: ADD_SERVICE_CUSTOMER_FAIL,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              LOADING_LOTTIE,
            ),
            const SizedBox(height: DIMEN_15),
            const Text(
              'SAVING YOUR DETAILS',
              style: TextStyle(
                fontSize: DIMEN_25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
