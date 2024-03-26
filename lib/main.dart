import 'package:flutter/material.dart';
import 'package:off_yaba/home.dart';
import 'package:off_yaba/manager.dart';
import 'package:off_yaba/market.dart';
import 'package:off_yaba/offers.dart';
import 'package:off_yaba/prop.dart';
import 'package:off_yaba/search.dart';
import 'package:off_yaba/select.dart';

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
