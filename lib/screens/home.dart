import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:off_yaba/screens/HomeScreen.dart';

import 'package:off_yaba/screens/offersScreen.dart';
import 'package:off_yaba/screens/scannerScreen.dart';
import 'package:off_yaba/screens/settingsScreen.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [const HomeScreen(), const ScannerScreen(), const OffersScreen(), const Settings()];
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.qr_code, size: 30, color: Colors.white),
          Icon(Icons.card_giftcard, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        color: appColor,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      // Set background color
      backgroundColor: Colors.white,
      body: SafeArea(child: pages[_page]),
    );
  }
}
