import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/pages/UikHome.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String animationAsset;
  final String message;

  const SuccessScreen({super.key, required this.animationAsset, required this.message});

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
                        builder: (context) => UikHome().page));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEE440), // Set the desired color
              ),
              child: const Text(
                "Home",
                style: TextStyle(
                  fontSize: DIMEN_25,
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
