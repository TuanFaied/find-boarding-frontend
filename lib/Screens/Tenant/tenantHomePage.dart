import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import './Pages/homePage.dart';
import './Pages/profile.dart';

class TenantHomePage extends StatefulWidget {
  @override
  _TenantHomePageState createState() => _TenantHomePageState();
}

class _TenantHomePageState extends State<TenantHomePage> {
  int _currentIndex = 0;
  final screens = [
   // Bookmark(),
    HomePage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      // Icon(
      //   Icons.bookmark,
      //   size: 30,
      // ),
      const Icon(
        Icons.home,
        size: 30,
      ),
      const Icon(
        Icons.person,
        size: 30,
      ),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 221, 133, 8),
      body: screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: kPrimaryLightColor,
        buttonBackgroundColor: const Color.fromARGB(255, 254, 218, 109),
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        height: 50,
        index: _currentIndex,
        items: items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
