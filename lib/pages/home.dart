import 'package:flutter/material.dart';
import 'package:login/pages/test_screen1.dart';
import 'package:login/pages/test_screen2.dart';
import 'package:login/pages/test_screen3.dart';
import 'package:login/pages/test_screen4.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<Widget> _pages = <Widget>[
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_activity_outlined,
              color: Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined, color: Colors.black),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Colors.black), label: "")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
