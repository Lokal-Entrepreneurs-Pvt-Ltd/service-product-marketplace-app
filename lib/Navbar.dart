import 'package:flutter/material.dart';
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

class Navbar extends StatefulWidget {
  @override
  State<Navbar> createState() => _NavbarState();
}

var currentSection = DrawerSections.home;

class _NavbarState extends State<Navbar> {
 @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFBDBDBD),
      child: ListView(
        children: [
          ListTile(
            selected: currentSection == DrawerSections.dashboard ,
            selectedTileColor: Color(0xFFFEE440),
              selectedColor: Colors.black,
              title: Text('Dashboard', style: TextStyle(fontSize: 16),),
              leading: Icon(
                  Icons.home_sharp,
                ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
                currentSection = DrawerSections.dashboard;
              }
          ),
          ListTile(
            selected: currentSection == DrawerSections.support,
            selectedTileColor: Color(0xFFFEE440),
              selectedColor: Colors.black,
              title: Text('Support', style: TextStyle(fontSize: 16),),
              leading: Icon(
                Icons.support_sharp,
                ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Support()));
                currentSection = DrawerSections.support;
              }
          ),
          Divider(
            color: Colors.white,
            indent: 15.0,
            endIndent: 15.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: currentSection == DrawerSections.usermanagement ||
                  currentSection == DrawerSections.announcements ||
              currentSection == DrawerSections.vlemanagement ||
              currentSection == DrawerSections.registervle ||
              currentSection == DrawerSections.productmanagement,
              childrenPadding: EdgeInsets.symmetric(horizontal: 25.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              iconColor: Colors.black,
                textColor: Colors.black,
                title: Text('System', style: TextStyle(fontSize: 18),),
            children: [
              ListTile(
                selected: currentSection == DrawerSections.usermanagement,
                selectedTileColor: Color(0xFFFEE440),
                selectedColor: Colors.black,
                title: Text('User Management', style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserManagement()));
                  currentSection = DrawerSections.usermanagement;
                  },
              ),
              SizedBox(height: 15.0,),
              ListTile(
                selected: currentSection == DrawerSections.announcements,
                selectedTileColor: Color(0xFFFEE440),
                selectedColor: Colors.black,
                title: Text('Announcements', style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Announcements()));
                  currentSection = DrawerSections.announcements;
                },
              ),
              SizedBox(height: 15.0,),
              ListTile(
                selected: currentSection == DrawerSections.vlemanagement,
                selectedTileColor: Color(0xFFFEE440),
                selectedColor: Colors.black,
                title: Text('VLE Management', style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VLEManagement()));
                  currentSection = DrawerSections.vlemanagement;
                },
              ),
              SizedBox(height: 15.0,),
              ListTile(
                selected: currentSection == DrawerSections.registervle,
                selectedTileColor: Color(0xFFFEE440),
                selectedColor: Colors.black,
                title: Text('Register VLE', style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterVLE()));
                  currentSection = DrawerSections.registervle;
                },
              ),
              SizedBox(height: 15.0,),
              ListTile(
                selected: currentSection == DrawerSections.productmanagement,
                selectedTileColor: Color(0xFFFEE440),
                selectedColor: Colors.black,
                title: Text('Product Management', style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductManagement()));
                  currentSection = DrawerSections.productmanagement;
                },
              ),
              SizedBox(height: 15.0,),
            ],
            ),
          ),
          Divider(
            color: Colors.white,
            indent: 15.0,
            endIndent: 15.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: currentSection == DrawerSections.radiusmanagement,
              childrenPadding: EdgeInsets.symmetric(horizontal: 25.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              iconColor: Colors.black,
              textColor: Colors.black,
              title: Text('Network', style: TextStyle(fontSize: 18),),
              children: [
                ListTile(
                  selected: currentSection == DrawerSections.radiusmanagement,
                  selectedTileColor: Color(0xFFFEE440),
                  selectedColor: Colors.black,
                  title: Text('Radius Management', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RadiusManagement()));
                    currentSection = DrawerSections.radiusmanagement;
                  },
                ),
                SizedBox(height: 15.0,),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
            indent: 15.0,
            endIndent: 15.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: currentSection == DrawerSections.subscriberreports ||
                  currentSection == DrawerSections.fnareports ||
                  currentSection == DrawerSections.nnsreports ||
                  currentSection == DrawerSections.generalreports,
              childrenPadding: EdgeInsets.symmetric(horizontal: 25.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              iconColor: Colors.black,
              textColor: Colors.black,
              title: Text('Reports Management', style: TextStyle(fontSize: 16),),
              children: [
                ListTile(
                  selected: currentSection == DrawerSections.subscriberreports,
                  selectedTileColor: Color(0xFFFEE440),
                  selectedColor: Colors.black,
                  title: Text('Subscriber Reports', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SubscriberRoutes()));
                    currentSection = DrawerSections.subscriberreports;
                  },
                ),
                SizedBox(height: 15.0,),
                ListTile(
                  selected: currentSection == DrawerSections.fnareports,
                  selectedTileColor: Color(0xFFFEE440),
                  selectedColor: Colors.black,
                  title: Text('Finance & Accounts Reports', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FNAReports()));
                    currentSection = DrawerSections.fnareports;
                  },
                ),
                SizedBox(height: 15.0,),
                ListTile(
                  selected: currentSection == DrawerSections.nnsreports,
                  selectedTileColor: Color(0xFFFEE440),
                  selectedColor: Colors.black,
                  title: Text('Network & Support Reports', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NNSReports()));
                    currentSection = DrawerSections.nnsreports;
                  },
                ),
                SizedBox(height: 15.0,),
                ListTile(
                  selected: currentSection == DrawerSections.generalreports,
                  selectedTileColor: Color(0xFFFEE440),
                  selectedColor: Colors.black,
                  title: Text('General Reports', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GeneralReports()));
                    currentSection = DrawerSections.generalreports;
                  },
                ),
                SizedBox(height: 15.0,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


enum DrawerSections {
  home,
  dashboard,
  support,
  usermanagement,
  announcements,
  vlemanagement,
  registervle,
  productmanagement,
  radiusmanagement,
  subscriberreports,
  fnareports,
  nnsreports,
  generalreports,
}
