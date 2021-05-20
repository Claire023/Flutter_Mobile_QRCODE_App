import 'package:flutter/material.dart';
import 'package:mspr/screens/HomeScreen.dart';
import 'package:mspr/screens/ScanScreen.dart';
import 'package:mspr/screens/PromosScreen.dart';

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // int _currentIndex = 0;

  PageController pageController =
      PageController(initialPage: 1, keepPage: true);

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ScanScreen(),
    PromosScreen()
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    print(selectedIndex);
    pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: _widgetOptions,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      // body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff000000),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: 'QR Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Promos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff75005a),
        onTap: _onItemTapped,
      ),
    );
  }
}
