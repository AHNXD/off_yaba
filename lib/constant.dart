import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const appColor = Color(0xFF58aad6);
String lang = "ar";
// for camera
QRViewController? controller;
bool camOn = true;
Color camOncolor = Colors.blue;

const String bg = "assets/BG.jpg";
const String logo = 'assets/offYaba.png';
void message(String error, Color c, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: c,
    content: Center(child: Text(error)),
    duration: const Duration(seconds: 2),
  ));
}

Route goRoute({required var x}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => x,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.fastEaseInToSlowEaseOut;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
