import 'package:daily_vegan_app/src/screens/calendar_screen.dart';
import 'package:daily_vegan_app/src/screens/dashboard_screen.dart';
import 'package:daily_vegan_app/src/screens/homeScreen.dart';
import 'package:daily_vegan_app/src/widgets/add_item_form.dart';
import 'package:daily_vegan_app/src/screens/add_screen.dart';
import 'package:daily_vegan_app/src/widgets/calendar.dart';
import 'package:daily_vegan_app/src/widgets/information.dart';
import 'package:flutter/material.dart';
import 'package:daily_vegan_app/src/screens/profile.dart';

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
    // HomeScreen(),
    DashBoardScreen(),
    Calendar(),
    Information(),
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
