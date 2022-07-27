import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uik_text/pages/announcements.dart';
import 'package:uik_text/pages/dashboard.dart';
import 'package:uik_text/pages/fnaReports.dart';
import 'package:uik_text/pages/generalReports.dart';
import 'package:uik_text/pages/nnsReports.dart';
import 'package:uik_text/pages/productManagement.dart';
import 'package:uik_text/pages/radiusManagement.dart';
import 'package:uik_text/pages/registerVLE.dart';
import 'package:uik_text/pages/subscriberReports.dart';
import 'package:uik_text/pages/support.dart';
import 'package:uik_text/pages/userManagement.dart';
import 'package:uik_text/pages/vleManagement.dart';

import './Navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => (
          Scaffold(
            appBar: AppBar(),
            drawer: Navbar(),
          )
        ),
        '/announcements' : (context) => Announcements(),
        '/dashboard' : (context) => Dashboard(),
        '/fnareports' : (context) => FNAReports(),
        '/generalreports' : (context) => GeneralReports(),
        '/nnsreports' : (context) => NNSReports(),
        '/productmanagement' : (context) => ProductManagement(),
        '/radiusmanagement' : (context) => RadiusManagement(),
        '/registervle' : (context) => RegisterVLE(),
        '/subscriberreports' : (context) => SubscriberRoutes(),
        '/support' : (context) => Support(),
        '/usermanagement' : (context) => UserManagement(),
        '/vlemanagement' : (context) => VLEManagement(),
      },
    );
  }
}
