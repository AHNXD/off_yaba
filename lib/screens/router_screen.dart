// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:off_yaba/screens/home_screen.dart';

import 'package:off_yaba/screens/offers_screen.dart';
import 'package:off_yaba/screens/scanner_screen.dart';
import 'package:off_yaba/screens/settings_screen.dart';

class RouterScreen extends StatefulWidget {
  static const routeName = '/router';
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  List pages = [
    const HomeScreen(),
    const ScannerScreen(),
    const OffersScreen(),
    const Settings()
  ];
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.qr_code_scanner, size: 30, color: Colors.white),
            Icon(Icons.card_giftcard, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
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
        // backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(child: pages[_page])),
      ),
    );
  }
}
