import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/screens/addServiceCustomerFlow/addServiceCustomerFlow.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final String animationAsset;
  final String message;

  ErrorScreen({required this.animationAsset, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(animationAsset),
            const SizedBox(height: DIMEN_16),
            Text(message),
            const SizedBox(height: DIMEN_25,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddServiceCustomerFlow()));
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFEE440), // Set the desired color
              ),
              child: const Text(
                "Change",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
