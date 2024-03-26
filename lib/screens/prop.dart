// Import libraries
import 'package:flutter/material.dart';

class Prop extends StatelessWidget {
  static const routeName = '/prop';
  const Prop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("data")),
    );
  }
}
