// Import libraries
import 'package:flutter/material.dart';

class Resturant extends StatefulWidget {
  static const routeName = '/rest';
  const Resturant({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Resturant> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("data")),
    );
  }
}
