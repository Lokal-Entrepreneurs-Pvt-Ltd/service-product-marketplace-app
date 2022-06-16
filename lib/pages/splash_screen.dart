import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/login.dart';
import 'package:login/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Text(
        "Local",
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 32),
      ),
      nextScreen: Home(),
      splashTransition: SplashTransition.fadeTransition,
      curve: Curves.easeInExpo,
      animationDuration: Duration(seconds: 2),
      backgroundColor: Color(0xffFEEB70),
    );
  }
}
