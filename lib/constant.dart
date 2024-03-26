import 'package:flutter/material.dart';

const appColor = Color(0xFF58aad6);
String lang = "";

void massege(String error, Color c, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: c,
    content: Center(child: Text(error)),
    duration: const Duration(seconds: 2),
  ));
}