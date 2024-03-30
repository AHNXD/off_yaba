import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/categoriesScreen.dart';
import 'package:off_yaba/screens/codeScreen.dart';
import 'package:off_yaba/screens/restaurantScreen.dart';
import 'package:off_yaba/screens/searchScreen.dart';
import 'package:off_yaba/screens/authScreen.dart';
import 'package:off_yaba/screens/signInScreen.dart';
import 'package:off_yaba/screens/signUpScreen.dart';
import 'package:off_yaba/screens/splashScreen.dart';
import 'package:off_yaba/screens/routerScreen.dart';

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
      initialRoute: SplashScreen.routeName,
      routes: {
        RouterScreen.routeName: (context) => const RouterScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        RestaurantScreen.routeName: (context) => const RestaurantScreen(),
        SplashScreen.routeName: (contex) => const SplashScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        CodeScreen.routeName: (context) => const CodeScreen()
      },
    );
  }
}
