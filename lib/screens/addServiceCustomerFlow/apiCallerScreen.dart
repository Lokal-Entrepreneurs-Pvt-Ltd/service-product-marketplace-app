import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/screens/addServiceCustomerFlow/errorScreen.dart';
import 'package:lokal/screens/addServiceCustomerFlow/successScreen.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:lokal/utils/storage/product_data_handler.dart';
import 'package:lottie/lottie.dart';

import '../../constants/strings.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';

class ApiCallerScreen extends StatefulWidget {
  String apiRoute;
  final Map<String, dynamic> args;

  ApiCallerScreen({required this.apiRoute, required this.args});

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
      final response =
          await ApiRepository.apiCallerScreen(widget.apiRoute, widget.args);
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
