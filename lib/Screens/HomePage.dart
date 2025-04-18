import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'HomeContent.dart';
import 'lib/Screens/Hospital.dart';
import 'lib/Screens/History.dart';
import 'lib/Screens/SettingsScreens/Settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    HospitalMapScreen(),
    History(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.local_hospital, size: 30),
      Icon(Icons.history, size: 30),
      Icon(Icons.settings, size: 30),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: _screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          color: Color(0xFF00BCD4),
          buttonBackgroundColor: Color(0xFFF8F9FA),
          backgroundColor: Colors.transparent,
          index: _currentIndex,
          height: 50,
          items: items,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
