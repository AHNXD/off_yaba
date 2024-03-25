import 'package:flutter/material.dart';
import 'package:off_yaba/%D8%A7%D9%84%D8%A8%D8%AD%D8%AB.dart';
import 'package:off_yaba/%D8%A7%D9%84%D8%AE%D8%AF%D9%88%D9%84%20%D9%83%D8%B5%D8%A7%D8%AD%D8%A8%20%D9%85%D8%AD%D9%84%20%D8%A7%D9%88%20%D9%85%D8%B7%D8%B9%D9%85.dart';
import 'package:off_yaba/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9%20%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9.dart';
import 'package:off_yaba/%D8%A7%D9%84%D8%B9%D8%B1%D9%88%D8%B6.dart';
import 'package:off_yaba/%D8%A7%D9%84%D9%85%D8%AD%D9%84.dart';
import 'package:off_yaba/%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Login.routeName,
      routes: {
        Home.routeName: (context) => Home(),
        Search.routeName: (context) => Search(),
        Resturant.routeName: (context) => Resturant(),
        Offers.routeName: (context) => Offers(),
        Prop.routeName: (context) => Prop(),
        Login.routeName: (context) => Login()
      },
    );
  }
}
