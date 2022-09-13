import 'package:flutter/material.dart';
import 'Widgets/UikTabBarSticky/UikBottomNavigationBar.dart';

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
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Bookkeeper(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFEEB70),
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
