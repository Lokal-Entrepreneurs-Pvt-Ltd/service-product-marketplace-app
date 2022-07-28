import 'package:flutter/material.dart';
import 'package:uik_text/Navbar.dart';

class RegisterVLE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(),
      drawer: Navbar(),
      body: Center(
        child: Text('Register VLE'),
      ),
    ),
    );
  }
}
