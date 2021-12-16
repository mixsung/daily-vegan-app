import 'package:daily_vegan_app/src/mainpages/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/pages/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'controller/authentication.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    (BottomNavigationBarItem(
        label: '1번',
        icon: ImageIcon(AssetImage('assets/first_component.png')))),
    BottomNavigationBarItem(
        label: '2번',
        icon: ImageIcon(AssetImage('assets/second_component.png'))),
    BottomNavigationBarItem(
        label: '늪페이지',
        icon: ImageIcon(
          AssetImage('assets/third_component.png'),
        )),
    BottomNavigationBarItem(
        label: '4번', icon: ImageIcon(AssetImage('assets/last_component.png')))
  ];

  List pages = [
    HomeScreen(),
    Container(
      child: Center(child: Text('2번입니다')),
    ),
    Container(
      child: Center(child: Text('3번입니다')),
    ),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 75.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(.60),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: bottomItems),
      body: pages[_selectedIndex],
    );
  }
}
