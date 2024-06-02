// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:off_yaba/screens/cart_screen.dart';
import 'package:off_yaba/screens/home_screen.dart';

import 'package:off_yaba/screens/offers_screen.dart';
import 'package:off_yaba/screens/reports_screen.dart';
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
    const Settings(),
    const CartScreen(),
    const HomeScreen(),
    const OffersScreen(),
    const ReportsScreen(),
  ];
  int _page = 2;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: 60.0,
          items: <Widget>[
            const Icon(Icons.person, size: 30, color: Colors.white),
            const Icon(Icons.shopping_cart, size: 30, color: Colors.white),
            Image.asset(
              logo,
              color: _page == 2 ? null : Colors.white,
              width: _page == 2 ? 40 : 40,
              height: _page == 2 ? 40 : 40,
            ),
            const Icon(Icons.card_giftcard, size: 30, color: Colors.white),
            const Icon(Icons.chat, size: 30, color: Colors.white),
          ],
          color: appColor,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
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
            color: Colors.grey.shade200,
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(child: pages[_page])),
      ),
    );
  }
}
