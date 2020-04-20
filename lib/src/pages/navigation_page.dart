import 'package:flutter/material.dart';

import 'package:calcu_obstetrica/src/pages/about_page.dart';
import 'package:calcu_obstetrica/src/pages/home_page.dart';
// import 'package:score_mama/src/pages/test_stfull.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AboutPage(),
    // TestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(255, 255, 255, 0.6),
        primaryColor: Color.fromRGBO(4, 78, 84, 1.0),
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(
                color: Colors.blueGrey[800],
              ),
            ),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.apps, size: 30.0),
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.info, size: 30.0),
          ),
          // BottomNavigationBarItem(
          //   title: Container(),
          //   icon: Icon(Icons.text_fields, size: 30.0),
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // selectedItemColor: Colors.amber[800],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
