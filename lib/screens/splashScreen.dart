// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/authScreen.dart';
import 'package:off_yaba/screens/routerScreen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late final Animation<double> _scaleAnimation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void next() async {
      await Future.delayed(const Duration(milliseconds: 2000), () async {
        // int res = await ApiService.adminLogin("admin", "123");
        // if (res == 200) {
        //   Navigator.pop(context);
        //   Navigator.of(context).push(goRoute(x: const Home()));
        //   message("Welcome Admin", Colors.green, context);
        // } else {
        //   message("There was an error, Check your connection and try again",
        //       Colors.red, context);
        // }
        Navigator.pop(context);
        if (isLogin) {
          Navigator.of(context).push(goRoute(x: const RouterScreen()));
        } else {
          Navigator.of(context).push(goRoute(x: const AuthScreen()));
        }
      });
    }

    next();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background2.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: ScaleTransition(
              scale: _scaleAnimation,
              child: Padding(
                padding: const EdgeInsets.all(64.0),
                child: Image.asset("assets/offYaba.png"),
              )),
        ),
      ),
    );
  }
}
