// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/services/cache_helper.dart';

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
      await Future.delayed(const Duration(milliseconds: 4500), () async {
        Navigator.pop(context);
        String? token = await CacheHelper.getData(key: "token");
        if (token != null) {
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
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: Image.asset("assets/offYaba.png"),
                )),
          )
              .animate()
              .slideY(duration: 1.seconds)
              .then()
              .scale(duration: 1.seconds)
              .fadeIn(duration: 1.seconds)
              .then()
              .shimmer(duration: 1.seconds)),
    );
  }
}
