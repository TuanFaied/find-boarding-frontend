import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:findboarding/Screens/Owner/Pages/addBoarding.dart';
import 'package:findboarding/Screens/Owner/Pages/home.dart';
import 'package:findboarding/Screens/Owner/Pages/profile.dart';
import 'package:findboarding/constants.dart';
import 'package:flutter/material.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  int _currentIndex = 1;
  final screens = [
   // Bookmark(),
    AddBoarding(),
    HomePage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.add_home,
        size: 30,
      ),
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