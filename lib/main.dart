import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/home.dart';
import 'package:off_yaba/screens/manager.dart';
import 'package:off_yaba/screens/market.dart';
import 'package:off_yaba/screens/offers.dart';
import 'package:off_yaba/screens/prop.dart';
import 'package:off_yaba/screens/search.dart';
import 'package:off_yaba/screens/select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Off-Yaba',
      theme: ThemeData(
        fontFamily: 'Hacen Beirut',
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
        useMaterial3: true,
      ),
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => const Home(),
        Search.routeName: (context) => const Search(),
        Resturant.routeName: (context) => const Resturant(),
        Offers.routeName: (context) => const Offers(),
        Prop.routeName: (context) => const Prop(),
        Login.routeName: (context) => const Login(),
        Select.routeName: (context) => const Select()
      },
    );
  }
}
