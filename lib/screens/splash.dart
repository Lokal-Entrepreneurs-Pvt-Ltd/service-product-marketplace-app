import 'package:flutter/material.dart';
import 'package:lokal/screens/Onboarding/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffFEEB70),
        child: Center(
          child: Image.asset(
            "assets/images/Launch.png",
            width: 225,
            height: 132,
          ),
        ),
      ),
    );
  }
}
